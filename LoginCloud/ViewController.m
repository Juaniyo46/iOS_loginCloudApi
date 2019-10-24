//
//  ViewController.m
//  LoginCloud
//
//  Created by Juan Alvarez on 24/10/2019.
//  Copyright © 2019 Juan Alvarez. All rights reserved.
//

#import "ViewController.h"
#import "DentroViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Descargar imagen desde el servidor
    
    NSString *urlImgStr = @"https://media.licdn.com/dms/image/C4E0BAQFu48fnxsSkEg/company-logo_200_200/0?e=2159024400&v=beta&t=XTnm9bY0TBRzEw-1i5D8xKsDeSsAzlZ1e6LLw6LzgRg";
    NSURL *imgUrl = [NSURL URLWithString:urlImgStr];
    
    NSData * imgData = [[NSData alloc] initWithContentsOfURL:imgUrl];
    
    self.imagen.image = [UIImage imageWithData:imgData];
    
}

- (IBAction)loginBtn:(id)sender{
    
    NSString *userStr = self.userText.text;
    NSString *passStr = self.passText.text;
    
    NSLog(@"user: %@, pass: %@",userStr,passStr);
    
    //creamos el objeto NSURLsession
    NSURLSession *session = [NSURLSession sharedSession];
    
    //Creamos objeto NSURL
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"https://qastusoft.com.es/apis/login.php?user=%@&pass=%@",userStr,passStr]];
    
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        NSNumber *resCode = [res valueForKey:@"code"];
        
        NSLog(@"%@",resCode);
        
        if ([resCode isEqualToNumber:@1]){
            
            //success
            NSLog(@"Login Correcto");
            
            //Cambiar de pantalla al hacer login
            UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            DentroViewController * dvc = (DentroViewController *) [storyBoard instantiateViewControllerWithIdentifier:@"dentroViewController"];
            dispatch_async(dispatch_get_main_queue(), ^{dvc.modalPresentationStyle = UIModalPresentationFullScreen;
                [self presentViewController:dvc animated:YES completion:nil];
            });
            
        }else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *errorMsg = [NSString stringWithFormat:@"%@", [res valueForKey:@"data"]];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:ok];
                
                [self presentViewController:alert animated:YES completion:nil];
            });
            
        }
        
        
    }];
    
    //ejecutar tarea
    [task resume];
}



@end
