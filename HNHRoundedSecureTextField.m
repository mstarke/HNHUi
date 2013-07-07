//
//  HNHRoundedSecureTextField.m
//  MacPass
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

#import "HNHRoundedSecureTextField.h"
#import "HNHRoundedSecureTextFieldCell.h"
#import "HNHRoundedTextFieldCell.h"

@implementation HNHRoundedSecureTextField

+ (Class)cellClass {
  return [HNHRoundedSecureTextFieldCell class];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if(self) {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [[self cell] encodeWithCoder:archiver];
    [archiver finishEncoding];
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    HNHRoundedSecureTextFieldCell *cell = [[HNHRoundedSecureTextFieldCell alloc] initWithCoder:unarchiver];
    [unarchiver finishDecoding];
    
    [self setCell:cell];
    [self setNeedsDisplay:YES];
    [self setDelegate:self];
  }
  return self;
}

- (void)setDisplayType:(HNHSecureTextFieldDisplayType)displayType {
  if(_displayType == displayType) {
    return; // No change;
  }
  NSLog(@"newDisplayType: %ld", displayType);
  HNHSecureTextFieldDisplayType oldType = _displayType;
  _displayType = displayType;
  
  [self _updateForDisplayTypeChange:oldType newType:displayType];
  
}
- (BOOL)resignFirstResponder {
  if([self currentEditor]) {
    if(_displayType == HNHSecureTextFieldClearTextWhileEdit) {
      [self swapCellForOneOfClass:[HNHRoundedTextFieldCell class]];
    }
  }
  return [super resignFirstResponder];
}

- (void)controlTextDidEndEditing:(NSNotification *)obj {
  if(_displayType == HNHSecureTextFieldClearTextWhileEdit) {
    [self swapCellForOneOfClass:[HNHRoundedSecureTextFieldCell class]];
  }
}

- (void)toggleDisplayType:(id)sender {
  self.displayType = (_displayType + 1) % HNHSecureTextFieldDisplayTypeCount;
}

- (void)swapCellForOneOfClass:(Class)cellClass;
{
  // Rememeber current selection for restoration after the swap
  // -valueForKey: neatly gives nil if no currently selected
  NSValue *selection = [[self currentEditor] valueForKey:@"selectedRange"];
  
  // Seems to me the best way to ensure all properties come along for the ride (e.g. border/editability) is to archive the existing cell
  NSMutableData *data = [[NSMutableData alloc] init];
  NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
  [[self cell] encodeWithCoder:archiver];
  [archiver finishEncoding];
  
  NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
  NSTextFieldCell *cell = [[cellClass alloc] initWithCoder:unarchiver];
  [unarchiver finishDecoding];
  
  [self setCell:cell];
  [self setNeedsDisplay:YES];
  
  // Restore selection
  
  //[self.window makeFirstResponder:self];
  if (selection) [[self currentEditor] setSelectedRange:[selection rangeValue]];
}

- (void)_updateForDisplayTypeChange:(HNHSecureTextFieldDisplayType)oldType newType:(HNHSecureTextFieldDisplayType)newType {
  /*
   Decide if we are editing or not
   1. We not editing
      Swap cells only if the unedited view need swapping
   
   2. We are editing
      Swap cell if editing view needs change
      View need to swap cell back when editor is finished
   */
  if([self currentEditor]) {  
  }
}

@end
