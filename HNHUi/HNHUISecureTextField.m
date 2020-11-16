//
//  HNHRoundedSecureTextField.m
//
//  Created by Michael Starke on 07.07.13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//
//  Based on: KSPasswordField.h
//
//  Created by Mike Abdullah on 28/04/2012.
//  Copyright (c) 2012 Karelia Software. All rights reserved.
//  http://karelia.com
//
//  Licensed under the BSD License <http://www.opensource.org/licenses/bsd-license>
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
//  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
//  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
//  SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
//  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
//  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
//  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
//  STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
//  THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "HNHUISecureTextField.h"
#import "HNHUISecureTextFieldCell.h"
#import "HNHUITextFieldCell.h"
#import "HNHUITextView.h"
#import "HNHUITextField.h"

@interface HNHUISecureTextField () {
  NSTrackingArea *_trackingArea;
}
@property (nonatomic, readonly) BOOL requiresTrackingArea;
@end

@implementation HNHUISecureTextField

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if(self) {
    NSError *error = nil;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.cell requiringSecureCoding:NO error:&error];
    NSAssert(error == nil, @"Unexpected error while archiving cell data");
    NSAssert(data, @"Unable to archive cell data.");
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingFromData:data error:&error];
    unarchiver.requiresSecureCoding = NO;
    HNHUISecureTextFieldCell *cell = [[HNHUISecureTextFieldCell alloc] initWithCoder:unarchiver];
    [unarchiver finishDecoding];
    
    self.cell = cell;
    _isMouseDown = NO;
    _isMouseOver = NO;
    
    self.needsDisplay = YES;
  }
  return self;
}

- (void)toggleDisplay:(id)sender {
  self.showPassword = !_showPassword;
}

- (void)setShowPassword:(BOOL)showPassword {
  if(_showPassword != showPassword) {
    _showPassword = showPassword;
    [self _toggleCell];
  }
}

- (BOOL)wantsUpdateLayer {
  return NO;
}

- (BOOL)requiresTrackingArea {
  return !self.isEditable && self.copyActionBlock;
}


/* vent HNHUISecureTextView delegation to HNHUITextFieldDelegate */
- (BOOL)textView:(NSTextView *)textView performAction:(SEL)action {
  if([[self.delegate class] conformsToProtocol:@protocol(HNHUITextFieldDelegate)]) {
    if([self.delegate respondsToSelector:@selector(textField:textView:performAction:)]) {
      return [((id<HNHUITextFieldDelegate>)self.delegate) textField:self textView:textView performAction:action];
    }
  }
  return YES;
}

#pragma mark -
#pragma mark Private
- (void)_swapCellForOneOfClass:(Class)cellClass;
{
  // Rememeber current selection for restoration after the swap
  // -valueForKey: neatly gives nil if no currently selected
  BOOL isActive = (nil != [self currentEditor]);
  if(isActive) {
    [self.window makeFirstResponder:nil]; // move the first responder away so the editing is finished
  }
  NSRange selectionRange =  [self currentEditor].selectedRange;
  
  // Seems to me the best way to ensure all properties come along for the ride (e.g. border/editability) is to archive the existing cell
  NSError *error = nil;
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.cell requiringSecureCoding:NO error:&error];
  NSAssert(!error, @"Unexpected error while swapping cells");
  NSAssert(data, @"Unable to work with nil data as cell data");
  
  NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingFromData:data error:&error];
  unarchiver.requiresSecureCoding = NO;
  NSTextFieldCell *cell = [[cellClass alloc] initWithCoder:unarchiver];
  [unarchiver finishDecoding];
  
  self.cell = cell;
  self.needsDisplay = YES;
  
  // Restore selection
  if(isActive) {
    [self.window makeFirstResponder:self];
  }
  if(selectionRange.location != NSNotFound && selectionRange.length > 0) {
    [self currentEditor].selectedRange = selectionRange;
  }
}

- (void)_toggleCell {
  if([self.cell isKindOfClass:[HNHUITextFieldCell class]]) {
    [self _swapCellForOneOfClass:[HNHUISecureTextFieldCell class]];
  }
  else {
    [self _swapCellForOneOfClass:[HNHUITextFieldCell class]];
  }
}

- (NSMenu *)textView:(NSTextView *)view menu:(NSMenu *)menu forEvent:(NSEvent *)event atIndex:(NSUInteger)charIndex {
  if([self.delegate respondsToSelector:@selector(textField:textView:menu:)]) {
    return [((id<HNHUITextFieldDelegate>)self.delegate) textField:self textView:view menu:menu];
  }
  return menu;
}


- (void)setEditable:(BOOL)flag {
  super.editable = flag;
  [self _updateTrackingArea];
}

- (void)mouseEntered:(NSEvent *)theEvent {
  _isMouseOver = YES;
  self.needsDisplay = YES;
}

- (void)mouseExited:(NSEvent *)theEvent {
  _isMouseOver = NO;
  _isMouseDown = NO;
  self.needsDisplay = YES;
}

- (void)mouseDown:(NSEvent *)theEvent {
  _isMouseDown = YES;
  self.needsDisplay = YES;
}

- (void)mouseUp:(NSEvent *)theEvent {
  _isMouseDown = NO;
  self.needsDisplay = YES;
  if(self.copyActionBlock) {
    self.copyActionBlock(self);
  }
}

- (void)viewWillMoveToWindow:(NSWindow *)newWindow {
  if(_trackingArea) {
    [self removeTrackingArea:_trackingArea];
  }
}

- (void)viewDidMoveToWindow {
  [self _updateTrackingArea];
}

- (void)setFrame:(NSRect)frameRect {
  super.frame = frameRect;
  [self _updateTrackingArea];
}

- (void)_updateTrackingArea {
  if(_trackingArea) {
    [self removeTrackingArea:_trackingArea];
    _trackingArea = nil;
  }
  if(self.requiresTrackingArea) {
    _trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect options:NSTrackingMouseEnteredAndExited|NSTrackingInVisibleRect|NSTrackingActiveAlways owner:self userInfo:nil];
    [self addTrackingArea:_trackingArea];
  }
}

@end
