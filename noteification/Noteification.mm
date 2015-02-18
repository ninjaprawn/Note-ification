#import "PSListController.h"
#import "PSSpecifier.h"
#import "PSViewController.h"
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

@interface NoteificationListController: PSListController <UIDocumentInteractionControllerDelegate> {
}
@end

@implementation NoteificationListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Noteification" target:self] retain];
	}
     if (![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/org.thebigboss.noteification.list"] && ![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/com.ninjaprawn.noteification.nc.list"])  {
        UIAlertView*theAlert = [[UIAlertView alloc] initWithTitle:@"Hey!" message:@"Excuse me, but you are using a pirated version of Note-ification. If you want to continue using this tweak, please buy the full version on the BigBoss repo!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [theAlert show];
        [theAlert release];
    }

	return _specifiers;
}

-(void)alertView:(UIAlertView *)theAlert clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        system("killall -SEGV SpringBoard");
    }
}

- (void)twitter:(id)twitter {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://twitter.com/theninjaprawn/"]];
}
- (NSString *) valueForSpecifier: (PSSpecifier *) specifier {
	return @"1.2.3-1";
}
- (void)openfile:(id)openfile {
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:@"/var/mobile/Library/Note-ification/noteification.txt"];
    UIDocumentInteractionController *controller = [UIDocumentInteractionController	interactionControllerWithURL:fileURL];
    [controller retain];
    controller.delegate = self;
    CGRect rect = CGRectMake(0, 0, 143, 148);
    [controller presentOptionsMenuFromRect:rect inView:self.view animated:YES];
}

-(void)savenote:(id)savenote {
    NoteContext *noteContext = [[NSClassFromString(@"NoteContext") alloc] init];
    NSManagedObjectContext *context = [noteContext managedObjectContext];
    NoteStoreObject *store = [noteContext defaultStoreForNewNote];
    NoteObject *note = [NSClassFromString(@"NSEntityDescription") insertNewObjectForEntityForName:@"Note" inManagedObjectContext:context];
    NoteBodyObject *body = [NSClassFromString(@"NSEntityDescription") insertNewObjectForEntityForName:@"NoteBody" inManagedObjectContext:context];
    // set body parameters
    NSString *notetext = [NSString stringWithContentsOfFile:@"/var/mobile/Library/Note-ification/noteification.txt" encoding:NSUTF8StringEncoding error:nil];
    NSArray *sep = [notetext componentsSeparatedByString:@"\n"];
    notetext = [sep componentsJoinedByString:@"<br />"];
    body.content = notetext;
    body.owner = note; // reference to NoteObject
    
    // set note parameters
    note.store = store; // reference to NoteStoreObject
    note.integerId = [noteContext nextIndex];
    note.title = [NSString stringWithContentsOfFile:@"/var/mobile/Library/Note-ification/title.txt" encoding:NSUTF8StringEncoding error:nil];
    note.summary = @"summary here";
    note.body = body; // reference to NoteBodyObject
    note.creationDate = [NSDate date];
    note.modificationDate = [NSDate date];
    NSError *error;
    BOOL success = [noteContext saveOutsideApp:&error];
    if (!success) {
        UIAlertView*theAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [theAlert show];
        [theAlert release];
    }
    [noteContext release];

}

@end

// vim:ft=objc
