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

@implementation HNHRoundedSecureTextField


- (void)setDisplayType:(HNHSecureTextFieldDisplayType)displayType {
  if(_displayType == displayType) {
    return; // No change;
  }
  _displayType = displayType;
  //[self swapCellForOneOfClass:(showsText ? [NSTextFieldCell class] : [NSSecureTextFieldCell class])];
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
  [self.window makeFirstResponder:self];
  if (selection) [[self currentEditor] setSelectedRange:[selection rangeValue]];
}

@end
