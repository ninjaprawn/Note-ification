#import "NoteificationController.h"

@implementation NoteificationController

@synthesize textField = _textField;
@synthesize titlebox = _titlebox;

-(id)init{
    if((self = [super init])){
	    int size;
	    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		    size = 400;
	    } else {
		    size = 200;
	    }
	    currentSize = CGSizeMake(self.view.frame.size.width,size);
	    showingMore = NO;
    }
    return self;
}

-(id)_weeAppView{
    return self.view;
}
- (void)hostWillPresent{
    //Init Stuff
    if (![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/org.thebigboss.noteification.list"] && ![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/com.ninjaprawn.noteification.nc.list"]) {
        UIAlertView*piratedAlert = [[UIAlertView alloc] initWithTitle:@"Hey!" message:@"Excuse me, but you are using a pirated version of Note-ification. If you want to continue using this tweak, please buy the full version on the BigBoss repo!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Damn!", nil];
        [piratedAlert show];
        [piratedAlert release];
    } else {
        if (![[NSFileManager defaultManager] fileExistsAtPath:@"/var/mobile/Library/Note-ification/noteification.txt"]) {
            NSString *greeting = @"Welcome to Note-ification!";
            [[NSFileManager defaultManager] createFileAtPath:@"/var/mobile/Library/Note-ification/noteification.txt" contents:[greeting 	dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
        }
        if (![[NSFileManager defaultManager] fileExistsAtPath:@"/var/mobile/Library/Note-ification/title.txt"]) {
            NSString *title = @"Title";
            [[NSFileManager defaultManager] createFileAtPath:@"/var/mobile/Library/Note-ification/title.txt" contents:[title dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
        }
        int fs = 16;
        BOOL bff = NO;
        int size;
        int button;
        int txtfdh;
        NSString *device = @"";
        NSString *fontn = @"AvenirNext";
        NSString *typef = @"Regular";
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            size = 400;
            button = 4;
            txtfdh = 37;
            device = @"/Library/Application Support/Note-ification/ipadnotesbg.png";
        } else {
            size = 200;
            button = 2;
            txtfdh = 34;
            device = @"/Library/Application Support/Note-ification/iphonenotesbg.png";
        }
        NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.ninjaprawn.noteification.prefs.plist"];
        if (prefs) {
            int fst = [[prefs objectForKey:@"FontSize"] integerValue];
            NSString *fontnt = [prefs objectForKey:@"FontName"];
            BOOL bfft = [[prefs objectForKey:@"bff"] boolValue];
            NSString *typeft = [prefs objectForKey:@"FontType"];
            if (fst) {
                fs = [[prefs objectForKey:@"FontSize"] integerValue];
            }
            if (fontnt) {
                fontn = [prefs objectForKey:@"FontName"];
            }
            if (bfft) {
                bff = [[prefs objectForKey:@"bff"] boolValue];
            }
            if (typeft) {
                typef = [prefs objectForKey:@"FontType"];
            }
        }
        
        //Share Button
        UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        myButton.frame = CGRectMake(self.view.frame.size.width - 24, button, 18, 24);
        [myButton setImage:[UIImage imageWithContentsOfFile:@"/Library/Application Support/Note-ification/share.png"] forState:UIControlStateNormal];
        [myButton addTarget:self action:@selector(showop:) forControlEvents:UIControlEventTouchUpInside];
        
        //Title Field
        _titlebox = [[UITextField alloc] initWithFrame:CGRectMake(20, button + 2, self.view.frame.size.width - 48, 24)];
        _titlebox.returnKeyType = UIReturnKeyDone;
        _titlebox.placeholder = @"Title of Note";
        NSString *titlec = [NSString stringWithContentsOfFile:@"/var/mobile/Library/Note-ification/title.txt" encoding:NSUTF8StringEncoding error:nil];
        [_titlebox setText:titlec];
        [_titlebox addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventEditingDidEndOnExit];
        
        //Text Field
        _textField = [[UITextView alloc] initWithFrame:CGRectMake(20, txtfdh, self.view.frame.size.width - 40, size-40)];
        _textField.returnKeyType = UIReturnKeyNext;
        _textField.tag = 100;
        NSString *contents = [NSString stringWithContentsOfFile:@"/var/mobile/Library/Note-ification/noteification.txt" encoding:NSUTF8StringEncoding error:nil];
        [_textField setText:contents];
        _textField.backgroundColor = [UIColor clearColor];
        //Alot of if statements for the font.
        if (bff) {
            if ([typef isEqualToString:@"Bold"]) {
                _textField.font = [UIFont boldSystemFontOfSize:fs];
            } else if ([typef isEqualToString:@"Italic"]) {
                _textField.font = [UIFont italicSystemFontOfSize:fs];
            } else {
                _textField.font = [UIFont systemFontOfSize:fs];
            }
        } else {
            if ([typef isEqualToString:@"Bold"]) {
                if ([fontn isEqualToString:@"Futura-Medium"]) {
                    _textField.font = [UIFont fontWithName:fontn size:fs];
                } else if ([fontn isEqualToString:@"TimesNewRomanPS"]) {
                    _textField.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:fs];
                } else {
                    _textField.font = [UIFont fontWithName:[NSString stringWithFormat: @"%@-Bold",fontn] size:fs];
                }
            } else if ([typef isEqualToString:@"Italic"]) {
                if ([fontn isEqualToString:@"Kailasa"] || [fontn isEqualToString:@"Courier"]) {
                    _textField.font = [UIFont fontWithName:fontn size:fs];
                } else if ([fontn isEqualToString:@"TimesNewRomanPS"]) {
                    _textField.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:fs];
                } else if ([fontn isEqualToString:@"Futura-Medium"]) {
                    _textField.font = [UIFont fontWithName:@"Futura-MediumItalic" size:fs];
                } else {
                    _textField.font = [UIFont fontWithName:[NSString stringWithFormat: @"%@-Italic",fontn] size:fs];
                }
            } else {
                if ([fontn isEqualToString:@"AvenirNext"] || [fontn isEqualToString:@"Menlo"] || [fontn isEqualToString:@"Optima"] || [fontn isEqualToString:@"Platino"]) {
                    _textField.font = [UIFont fontWithName:[NSString stringWithFormat: @"%@-Regular",fontn] size:fs];
                } else if ([fontn isEqualToString:@"TimesNewRomanPS"]) {
                    _textField.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:fs];
                } else {
                    _textField.font = [UIFont fontWithName:fontn size:fs];
                }
            }
        }
        
        //Background
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile: device]];
        imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, size);
        _textField.delegate = self;
        _titlebox.delegate = self;
        //Add the things to the view
        [self.view addSubview: imageView];
        [self.view addSubview:_textField];
        [self.view addSubview:myButton];
        [self.view addSubview:_titlebox];
        [imageView release];
        [_titlebox release];
        [_textField release];
    }
}
//For pirated stuff
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Damn!"]) {
        system("killall -SEGV SpringBoard");
    }
}
//The debugging code (substitute for NSLog)
-(void)test:(id)test {
    UIAlertView*theAlert = [[UIAlertView alloc] initWithTitle:@"Yo!" message:@"You pressed the menu!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [theAlert show];
    [theAlert release];
}
//Dismiss function
-(void)dismiss:(id)dismiss {
    [self.view endEditing:YES];
}
//Show popover
-(void)showop:(id)showop {
    [self.view endEditing:YES];
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Options:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Save to Notes",@"Share note...",nil];
    popup.tag = 1;
    [popup showInView:[self.view window]];
}
//See what button is pressed for popover
-(void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    [self saven];
                    break;
                case 1:
                    [self showdoc];
                    break;
                default:
                    break;
            }
        }
        default:
            break;
    }
}
//Save to notes function
-(void)saven {
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
        UIAlertView*noteAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [noteAlert show];
        [noteAlert release];
    }
    [noteContext release];

}

//Show DocInteractionController
- (void)showdoc {
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:@"/var/mobile/Library/Note-ification/noteification.txt"];
	UIDocumentInteractionController *controller = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
	[controller retain];
	controller.delegate = self;
	CGRect rect = CGRectMake(0, 0, 120, 200);
	[controller presentOptionsMenuFromRect:rect inView:self.view animated:YES];
}

//Other Stuff
- (BOOL)textFieldShouldBeginEditing:(UITextField *)titlebox{
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)titlebox {
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)titlebox{
	return YES;
}
//Save title when text field finished editiing
- (void)textFieldDidEndEditing:(UITextField *)titlebox{
    titlebox = _titlebox;
	NSString *str = _titlebox.text;
	[str writeToFile:@"/var/mobile/Library/Note-ification/title.txt" atomically:NO encoding:NSUTF8StringEncoding error:nil];
    [self.view endEditing:YES];
}
//If there is a touch outside of the elements not including static things
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[self.view endEditing:YES];
	[super touchesBegan:touches withEvent:event];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)_textField{
	return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)_textField {
}

- (BOOL)textViewShouldEndEditing:(UITextView *)_textField{
	return YES;
}
//When textfield finishes editing
- (void)textViewDidEndEditing:(UITextView *)textField{
	textField = _textField;
	NSLog(@"textViewDidEndEditing:");
	NSString *str = _textField.text;
    NSError *error;
    if (![str writeToFile:@"/var/mobile/Library/Note-ification/noteification.txt" atomically:NO encoding:NSUTF8StringEncoding error:&error]) {
        UIAlertView*saveAlert = [[UIAlertView alloc] initWithTitle:@"Send screenshot to dev" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yep!", nil];
        [saveAlert show];
        [saveAlert release];
    }
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.ninjaprawn.noteification.prefs.plist"];
    if (prefs) {
        BOOL savetnf = [[prefs objectForKey:@"saven"] boolValue];
        if (savetnf) {
            [self saven];
        }
    }
}

- (void)hostDidDismiss{
	[[self.view viewWithTag:100] removeFromSuperview];
}

- (void)hostDidPresent{
    
}

- (void)hostWillDismiss{
    
}

- (CGSize)preferredViewSize{
	return currentSize;
}

@end
