#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <Notes/AccountUtilities.h>
#import <Notes/CDStructures.h>
#import <Notes/MNFNoteProperty.h>
#import <Notes/NoteAccountObject-Private.h>
#import <Notes/NoteAccountObject.h>
#import <Notes/NoteBodyObject.h>
#import <Notes/NoteChangeObject.h>
#import <Notes/NoteCollectionObject.h>
#import <Notes/NoteContext.h>
#import <Notes/NoteObject-Private.h>
#import <Notes/NoteObject.h>
#import <Notes/NoteResurrectionMergePolicy.h>
#import <Notes/NoteSearchContext.h>
#import <Notes/NoteStoreObject.h>
#import "_SBUIWidgetViewController.h"

@interface NoteificationController : _SBUIWidgetViewController <UITextViewDelegate,UIDocumentInteractionControllerDelegate, UITextFieldDelegate, UIActionSheetDelegate> {
	CGSize currentSize;
	BOOL showingMore;
}

@property(nonatomic,retain) UITextView *textField;
@property(nonatomic,retain) UITextField *titlebox;

-(id)_weeAppView;
- (void)saven;

- (void)hostWillPresent;
- (void)hostDidPresent;
- (void)hostWillDismiss;
- (void)hostDidDismiss;
- (CGSize)preferredViewSize;
- (void)textViewDidEndEditing:(UITextView *) textField;

@end
