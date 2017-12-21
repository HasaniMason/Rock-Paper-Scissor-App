//
//  MYUiView.swift
//  App6 Rock Paper Scissor
//
//  Created by Hasani Mason on 11/28/17.
//  Copyright © 2017 Hasani Mason. All rights reserved.
//

import UIKit
import AVFoundation

class MYUiView: UIView {
    
    //Outlets
    @IBOutlet weak var winOrLoseLabel: UILabel!
    @IBOutlet weak var viewA: UIImageView!
    @IBOutlet weak var viewB: UIImageView!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var lionImage: UIImageView!
    @IBOutlet weak var cobraImage: UIImageView!
    @IBOutlet weak var rabbitImage: UIImageView!
    @IBOutlet weak var playerScore: UILabel!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneScore: UILabel!
    
    
    //Variables
    private var titleTimer : Timer!
    private var moveLionTimer: Timer!
    private var lionX: Int = 0
    private var lionY: Int = 0
    private var cobraX: Int = 0
    private var cobraY: Int = 0
    private var rabbitX: Int = 0
    private var rabbitY: Int = 0
    private var lionMoved: Bool = false
    private var rabitTouch: Bool = false
    private var cobraTouch: Bool = false
    private var offset : CGPoint = CGPoint(x: 0, y: 0)
    private var lionT = 0.0
    private var lionFrame: CGRect!
    private var rabbitFrame: CGRect!
    private var cobraFrame: CGRect!
    
    private var gamePositionA: CGRect!
    
    private var gamePositionB: CGRect!
    private var gameImageViews: [UIImageView]!
    private var gameStrings: [String]!
    
    private var currentLion = "0"
    private var viewAX = 0
    private var viewAY = 0
    
    private var playerScoreI = 0
    private var phoneScoreI = 0
    private var lionPlayer : AVPlayer!
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    required init?(coder aDecoder: NSCoder)
    {
        
        
        super.init(coder: aDecoder)
    }
    
    //runs the game
    override func  awakeFromNib()
    {
        //Calls the game function
        S_game()
    }
    
    //touch function (1)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        //Implement touches began here
        var all_touches = Array(touches)
  
        //Get all touches
        for i in 0..<all_touches.count
        {
            //Get the touch object
            let touch = all_touches[i] 
            
            //print("Touch info in tap: \(touch)")
            
            //Get the location where touch occurred
            let touchPoint = touch.location(in: self)
            
            //Display the location of the touch point
            //print("Touch occurred at \(touchPoint.x),\(touchPoint.y)")
            
            //Get the tap count
            let tap = touch.tapCount
            //print("Tap count is: \(tap)")
            
            //Get the touch
            let start_touch = all_touches[0]
            
            //Get the location
            // start_point = start_touch.location(in: self)
            
            //Get the time
            //   start_time = start_touch.timestamp;
            
            if ( (Int(touchPoint.x) > lionX) && (Int(touchPoint.x) < lionX + 50) && (Int(touchPoint.y) > lionY) &&
                (Int(touchPoint.y) < lionY + 50))
            {
                lionMoved = true
                offset.x = touchPoint.x - CGFloat(lionX)
                offset.y = touchPoint.y - CGFloat(lionY)
                moveLionTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(MYUiView.lionSwitch), userInfo: self, repeats: true)
                
                //print("Box touched")
            }
            
            
            if ( (Int(touchPoint.x) > cobraX) && (Int(touchPoint.x) < cobraX + 50) && (Int(touchPoint.y) > cobraY) &&
                (Int(touchPoint.y) < cobraY + 50))
            {
                cobraTouch = true
                offset.x = touchPoint.x - CGFloat(cobraX)
                offset.y = touchPoint.y - CGFloat(cobraY)
                
                
                //print("Box touched")
            }
            
            
            if ( (Int(touchPoint.x) > rabbitX) && (Int(touchPoint.x) < rabbitX + 50) && (Int(touchPoint.y) > rabbitY) &&
                (Int(touchPoint.y) < rabbitY + 50))
            {
                rabitTouch = true
                offset.x = touchPoint.x - CGFloat(rabbitX)
                offset.y = touchPoint.y - CGFloat(rabbitY)
                
                
                //print("Box touched")
            }
            
        }
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        let isinBackground = inBounds()
        
        if(isinBackground) {
            
            play()
            
        } else {
            
            returnToOriginalPos()
            
        }
        lionMoved = false;
        rabitTouch = false
        cobraTouch = false
        
        
        var all_touches = Array(touches)
        
        //Get all touches
        for i in 0..<all_touches.count
        {
            //Get the touch object
            let touch = all_touches[i] as! UITouch
            
            //print("Touch info in Ended \(touch)");
            
            //Get the location where touch occurred
            let touchPoint = touch.location(in: self)
            
            //Display the location of the touch point
            //print("Touch Ended occurred at: \(touchPoint.x)  \(touchPoint.y)");
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        //Implement touches moved here
        
        var all_touches = Array(touches)
        

        //Get all touches
        for i in 0..<all_touches.count
        {
            //Get the touch object
            let touch = all_touches[i] as! UITouch
            
            //print("Touch info in moved \(touch)");
            
            //Get the location where touch occurred
            let touchPoint = touch.location(in: self)
            
            let end_touch = all_touches[0]
            
            //Get the location
            // end_point = end_touch.location(in: self)
            
            //Get the time
            // end_time = end_touch.timestamp;
            
            if (cobraTouch == true)
            {
                cobraX = Int(touchPoint.x) - Int(offset.x)
                cobraY = Int(touchPoint.y) - Int(offset.y)
            }
            
            
            if (rabitTouch == true)
            {
                rabbitX = Int(touchPoint.x) - Int(offset.x)
                rabbitY = Int(touchPoint.y) - Int(offset.y)
            }
            
            
            if (lionMoved == true)
            {
                lionX = Int(touchPoint.x) - Int(offset.x)
                lionY = Int(touchPoint.y) - Int(offset.y)
                
                
                
                
            }
            
            //Display the location of the touch point
            //print("Touch Dragged occurred at: \(touchPoint.x)  \(touchPoint.y)");
            self.setNeedsDisplay()
        }
    }
    
    //starts the game
    func S_game() {
        
        //Zoom
        
        lionFrame = lionImage.frame
        rabbitFrame = rabbitImage.frame
        cobraFrame = cobraImage.frame
        
        
        
        //Flip rabbit image
        let flipped = UIImage(cgImage: (self.rabbitImage.image?.cgImage)!, scale: (self.rabbitImage.image?.scale)!, orientation: UIImageOrientation.upMirrored)
        self.rabbitImage.image = flipped
        
        //
        self.lionX = Int(self.lionImage.frame.origin.x)
        self.lionY = Int(self.lionImage.frame.origin.y)
        self.rabbitX = Int(self.rabbitImage.frame.origin.x)
        self.rabbitY = Int(self.rabbitImage.frame.origin.y)
        self.cobraX = Int(self.cobraImage.frame.origin.x)
        self.cobraY = Int(self.cobraImage.frame.origin.y)
        
        self.viewAX = Int(self.viewA.frame.origin.x)
        self.viewAY = Int(self.viewA.frame.origin.y)
        
        
        let frame = titleImage.frame;
        var  center : CGPoint = CGPoint(x: 0, y: 0)
        center.x = frame.origin.x + frame.size.width/2.0
        center.y = frame.origin.y + frame.size.height/2.0
        
        UIView.beginAnimations("Zoom", context: nil)
        UIView.setAnimationDuration(7)
        UIView.setAnimationDelegate(self)
  
        
        UIView.setAnimationRepeatCount(1.0)
        
        //Add properties to change here
        //Add properties to change
        titleImage.frame = CGRect(x: center.x - (3*frame.size.width/2), y: center.y - (3*frame.size.height/2), width: frame.size.width*3, height: frame.size.height*3);
        
        
        
        //    finish animation
        //   middle.frame = origMiddleFrame;
        UIView.commitAnimations();
        
        gameImageViews  = [lionImage, cobraImage, rabbitImage]
        gameStrings = ["lion","cobra", "rabbit"]
        //Fade
        titleTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector:#selector(MYUiView.timerFired), userInfo: self, repeats: false)
        
        titleTimer = Timer.scheduledTimer(timeInterval: 7.5, target: self, selector:#selector(MYUiView.timerFired1), userInfo: self, repeats: false)
        
        
    }
    
    func timerFired1() {
        
        playerLabel.isHidden = false
        phoneLabel.isHidden = false
        phoneScore.isHidden = false
        playerScore.isHidden = false
        
        titleTimer.invalidate()
    }
    
    
    //switches lion sequence
    func lionSwitch() {
        // print(lionT)
        if(lionMoved == false) {
            
            moveLionTimer.invalidate()
        }
        
        
        if(lionT == 0) {
            
            playSound()
            lionImage.image = UIImage(named: "lion1")
            currentLion = "1"
            
            
        }
        if(lionT == 1) {
            
            playSound()
            lionImage.image = UIImage(named: "lion2")
            currentLion = "2"
            
        }
        if( lionT == 2) {
            playSound()
            lionImage.image = UIImage(named: "lion3")
            currentLion = "3"
            
        }
        if(lionT == 3) {
            playSound()
            lionImage.image = UIImage(named: "lion0")
            currentLion = "0"
            
        }
        
        lionT += 1
        
        if(lionT == 4) {
            lionT = 0
        }
        
        
        
    }
    
    // allows user to play the game
    func play() {
        
        let number = Int(arc4random_uniform(2))
        var enemy = gameStrings[number]
        
        goToStartPos(animalNumber: number)
        
        
        if (cobraTouch == true)
        {
            
            let player = "cobra"
            // P_Loses(player1: player, enemy1: enemy)
            if(enemy == "rabbit") {
                print("rabbit wins!")
                P_Loses(player1: player, enemy1: enemy)
            } else if (enemy == "lion") {
                print("cobra wins")
                P_Wins(player1: player, enemy1: enemy)
            } else {
                print("ties")
                P_Ties(player: player, enemy1: enemy)
            }
            
            
        }
        
        
        if (rabitTouch == true)
        {
            let player = "rabbit"
            if(enemy == "cobra") {
                print("rabbit wins!")
                P_Wins(player1: player, enemy1: enemy)
            } else if (enemy == "lion") {
                print("lion wins")
                P_Loses(player1: player, enemy1: enemy)
            } else {
                print("ties")
                P_Ties(player: player, enemy1: enemy)
            }
            
            
            
        }
        
        
        if (lionMoved == true)
        {
            let player = "lion"
            if(enemy == "rabbit") {
                print("lion wins!")
                P_Wins(player1: player, enemy1: enemy)
            } else if (enemy == "cobra") {
                print("cobra wins")
                P_Loses(player1: player, enemy1: enemy)
            } else {
                print("ties")
                P_Ties(player: player, enemy1: enemy)
                
            }
            
        
            
        }
    
        
    }
    
    //calculates winner
    func P_Wins(player1: String, enemy1: String) {
        
        
        playerScoreI += 1
        playerScore.text = "\(playerScoreI)"
        var enemy = ""
        
        
        let str = "\(player1) defeats \(enemy1) - You Win!"
        
        fadeInOut(str: str)
        
        var num = 0
        
        if(player1 == "cobra") {
            num = 1
        }
        if(player1 == "rabbit") {
            num = 2
        }
        
        
        
        let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.goToPosWin(player: player1, num: num)
            
            
        }
        
        let when2 = DispatchTime.now() + 6 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when2) {
            var flipped: UIImage
            
            if(enemy1 == "lion") {
                enemy = "lion\(self.currentLion)"
                
                flipped = UIImage(cgImage: (UIImage(named: enemy)!.cgImage)!, scale: (UIImage(named: enemy)!.scale), orientation: UIImageOrientation.upMirrored)
                
                self.fadeOutA(image: flipped)
                
            } else if( enemy1 == "cobra"){
                
                flipped = UIImage(cgImage: (UIImage(named: enemy1)!.cgImage)!, scale: (UIImage(named: enemy1)!.scale), orientation: UIImageOrientation.upMirrored)
                self.fadeOutA(image: flipped)
                
                
                
            } else {
                self.fadeOutA(image: UIImage(named: enemy)!)
                
            }
            
        }
        
        let when3 = DispatchTime.now() + 9 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when3) {
            
            
            self.returnToOriginalPosWin(player: player1, num: num)
            
            
        }
        
        
    }
    
    // calculates if player 1 loses
    func P_Loses(player1: String, enemy1: String) {
        
        phoneScoreI += 1
        phoneScore.text = "\(phoneScoreI)"
        let str = "\(enemy1) defeats \(player1) - You Lose!"
        fadeInOut(str: str)
        var num = 0
        
        if(player1 == "cobra") {
            num = 1
        }
        if(player1 == "rabbit") {
            num = 2
        }
        
        
        let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.goToPosLose(enemy: enemy1, num: num)
            
            
        }
        
        
        let when2 = DispatchTime.now() + 5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when2) {
            
            
            var flipped: UIImage
            
            
            var enemy = enemy1
            
            if(enemy == "lion") {
                enemy = "lion\(self.currentLion)"
                
                flipped = UIImage(cgImage: (UIImage(named: enemy)!.cgImage)!, scale: (UIImage(named: enemy)!.scale), orientation: UIImageOrientation.upMirrored)
                
                //  self.fadeOutA(image: flipped)
                self.fadeOutB(image: UIImage(named: player1)!, playerStr: player1)
            } else if( enemy == "cobra"){
                
                flipped = UIImage(cgImage: (UIImage(named: enemy)!.cgImage)!, scale: (UIImage(named: enemy)!.scale), orientation: UIImageOrientation.upMirrored)
                // self.fadeOutA(image: flipped)
                if(player1 == "lion") {
                    var lionIMG = "lion\(self.currentLion)"
                    self.fadeOutB(image: UIImage(named: lionIMG)!, playerStr: player1)
                }else {
                    self.fadeOutB(image: UIImage(named: player1)!, playerStr: player1)
                }
                
                
            } else {
                //                flipped = UIImage(cgImage: (UIImage(named: player1)!.cgImage)!, scale: (UIImage(named: player1)!.scale), orientation: UIImageOrientation.upMirrored)
                //self.fadeOutA(image: UIImage(named: enemy)!)
                self.fadeOutB(image: UIImage(named:player1)!, playerStr: player1)
            }
            
            
        }
        
        
        let when3 = DispatchTime.now() + 8.2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when3) {
            
            self.returnToOriginalPos2(player: player1, num: num)
            
        }
        let when4 = DispatchTime.now() + 9.2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when4) {
            var flipped: UIImage
            
            if(enemy1 == "lion") {
                var lionstr = "lion\(self.currentLion)"
                var lionIMG = UIImage(named: lionstr)
                flipped = UIImage(cgImage: (lionIMG!.cgImage)!, scale: (lionIMG!.scale), orientation: UIImageOrientation.upMirrored)
                self.fadeOutA(image: flipped)
            }else  if(enemy1 == "cobra"){
                var cobraIMG = UIImage(named: enemy1)
                flipped = UIImage(cgImage: (cobraIMG!.cgImage)!, scale: (cobraIMG!.scale), orientation: UIImageOrientation.upMirrored)
                self.fadeOutA(image: flipped)
                
            } else {
                self.fadeOutA(image: UIImage(named: enemy1)!)
            }

            
            
        }
        
        
        
    }
    
    
    
    // calculates ties
    func P_Ties(player: String, enemy1: String ) {
        let str = "Tie!"
        fadeInOut(str: str)
        
        var num = 0
        
        if(player == "cobra") {
            num = 1
        }
        if(player == "rabbit") {
            num = 2
        }
        
        
        let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            var flipped: UIImage
            
            
            var enemy = enemy1
            print(enemy)
            if(enemy == "lion") {
                enemy = "lion\(self.currentLion)"
                
                flipped = UIImage(cgImage: (UIImage(named: enemy)!.cgImage)!, scale: (UIImage(named: enemy)!.scale), orientation: UIImageOrientation.upMirrored)
                
                self.fadeOutA(image: flipped)
                var lionPlay = "lion\(self.currentLion)"
                self.fadeOutB(image: UIImage(named: lionPlay)!, playerStr: player)
            } else if( enemy == "cobra"){
                
                flipped = UIImage(cgImage: (UIImage(named: enemy)!.cgImage)!, scale: (UIImage(named: enemy)!.scale), orientation: UIImageOrientation.upMirrored)
                self.fadeOutA(image: flipped)
                self.fadeOutB(image: UIImage(named: player)!, playerStr: player)
                
                
            } else {
                self.fadeOutA(image: UIImage(named: enemy)!)
                self.fadeOutB(image: UIImage(named: player)!, playerStr: player)
            }
            
            
        }
        
        
        let when2 = DispatchTime.now() + 8 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when2) {
            
            self.returnToOriginalPos2(player: player, num: num)
            
        }
        
        
        
    }
    
    func playSound() {
        if let path = Bundle.main.path(forResource: "LionRoar", ofType: "wav")  {
            let url = URL(fileURLWithPath: path)
            lionPlayer = AVPlayer(url: url)
            
            lionPlayer.play()
            
        } else {
            print("no sound file")
        }
        
    }
    
    // fades out image
    func fadeInOut(str: String) {
        
        
        
        let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            self.winOrLoseLabel.alpha = 0.0
            self.winOrLoseLabel.text = str
            
            UIView.beginAnimations("Fade", context: nil)
            
            
            UIView.setAnimationDuration(6.5)
            
            UIView.setAnimationDelegate(self)
            
            
            self.winOrLoseLabel.alpha = 1.0
            UIView.commitAnimations()
            
            
        }
        
        let when2 = DispatchTime.now() + 6 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when2) {
            
            self.winOrLoseLabel.alpha = 1.0
            self.winOrLoseLabel.text = str
            
            UIView.beginAnimations("Fade", context: nil)
            
            
            UIView.setAnimationDuration(6.5)
            
            UIView.setAnimationDelegate(self)
            
            
            self.winOrLoseLabel.alpha = 0.0
            UIView.commitAnimations()
            
            
        }
        
    
        
        
    }
    
    // returns winner
    func returnToOriginalPosWin(player: String, num: Int) {
        if (num == 0)
        {
            
            
            UIView.beginAnimations("Move", context: nil)
            
            
            UIView.setAnimationDuration(6.5)
            
            UIView.setAnimationDelegate(self)
            self.lionX = Int(self.lionFrame.origin.x)
            
            self.lionY = Int(self.lionFrame.origin.y)
            
            self.lionImage.frame = self.lionFrame;
            
            
            UIView.commitAnimations()
            
        }
        
        
        if (num == 1)
        {
            
            
            
            UIView.beginAnimations("Move", context: nil)
            
            
            UIView.setAnimationDuration(6.5)
            
            UIView.setAnimationDelegate(self)
            self.cobraX = Int(self.cobraFrame.origin.x)
            
            self.cobraY = Int(self.cobraFrame.origin.y)
            
            self.cobraImage.frame = self.cobraFrame;
        
            
            UIView.commitAnimations()
            
            
        }
        
        
        if (num == 2)
        {
            
            
            UIView.beginAnimations("Move", context: nil)
            
            
            UIView.setAnimationDuration(6.5)
            
            UIView.setAnimationDelegate(self)
            self.rabbitX = Int(self.rabbitFrame.origin.x)
            
            self.rabbitY = Int(self.rabbitFrame.origin.y)
            
            self.rabbitImage.frame = self.rabbitFrame;
        
            
            UIView.commitAnimations()
            
        }
        
    }
    
    
    func getPlayer(player: String) -> UIImageView {
        
        if(player == "cobra") {
            return cobraImage
        }
        if(player == "lion") {
            return lionImage
        }
        return rabbitImage
    }
    
    
    //gets the starting position
    func goToStartPos(animalNumber: Int) {
        
        
        
        if (cobraTouch == true)
        {
            print(animalNumber)
            cobraImage.frame = viewB.frame
            cobraX = Int(viewB.frame.origin.x)
            cobraY = Int(viewB.frame.origin.y)
            
            if(gameStrings[animalNumber] == "lion") {
                let flipped = UIImage(cgImage: (self.lionImage.image?.cgImage)!, scale: (self.lionImage.image?.scale)!, orientation: UIImageOrientation.upMirrored)
                
                fadeIn(image: flipped)
                
                
            }
            if(gameStrings[animalNumber] == "cobra") {
                let flipped = UIImage(cgImage: (self.cobraImage.image?.cgImage)!, scale: (self.cobraImage.image?.scale)!, orientation: UIImageOrientation.upMirrored)
                fadeIn(image: flipped)
                
            }
            if(gameStrings[animalNumber] == "rabbit") {
                
                viewA.image = UIImage(named: "rabbit")
                let rabbit = UIImage(named: "rabbit")
                fadeIn(image: rabbit!)
                
            }
            
        }
        
        
        if (rabitTouch == true)
        {
            
            print(animalNumber)
            rabbitImage.frame = viewB.frame
            rabbitX = Int(viewB.frame.origin.x)
            rabbitY = Int(viewB.frame.origin.y)
            
            if(gameStrings[animalNumber] == "lion") {
                let flipped = UIImage(cgImage: (self.lionImage.image?.cgImage)!, scale: (self.lionImage.image?.scale)!, orientation: UIImageOrientation.upMirrored)
                
                fadeIn(image: flipped)
                
            }
            if(gameStrings[animalNumber] == "cobra") {
                let flipped = UIImage(cgImage: (self.cobraImage.image?.cgImage)!, scale: (self.cobraImage.image?.scale)!, orientation: UIImageOrientation.upMirrored)
                fadeIn(image: flipped)
            }
            if(gameStrings[animalNumber] == "rabbit") {
                
                let rabbit = UIImage(named: "rabbit")
                fadeIn(image: rabbit!)
                
            }
            
            
        }
        
        
        if (lionMoved == true)
        {
            
            print(animalNumber)
            lionImage.frame = viewB.frame
            lionX = Int(viewB.frame.origin.x)
            lionY = Int(viewB.frame.origin.y)
            
            if(gameStrings[animalNumber] == "lion") {
                let flipped = UIImage(cgImage: (self.lionImage.image?.cgImage)!, scale: (self.lionImage.image?.scale)!, orientation: UIImageOrientation.upMirrored)
                
                fadeIn(image: flipped)
                
            }
            if(gameStrings[animalNumber] == "cobra") {
                let flipped = UIImage(cgImage: (self.cobraImage.image?.cgImage)!, scale: (self.cobraImage.image?.scale)!, orientation: UIImageOrientation.upMirrored)
                fadeIn(image: flipped)
            }
            if(gameStrings[animalNumber] == "rabbit") {
                
                let rabbit = UIImage(named: "rabbit")
                fadeIn(image: rabbit!)
                
            }
            
            
        }
        
        
        
        
    }
    
    func inBounds() -> Bool {
        
        
        if (cobraTouch == true)
        {
            if(backgroundImage.frame.contains(cobraImage.frame)) {
                return true
            }
        }
        
        
        if (rabitTouch == true)
        {
            if(backgroundImage.frame.contains(rabbitImage.frame)) {
                return true
            }
            
            
        }
        
        
        if (lionMoved == true)
        {
            
            if(backgroundImage.frame.contains(lionImage.frame)) {
                return true
            }
            
            
            
            
        }
        
        return false
    }
    
    // returns to orginal positon
    func returnToOriginalPos2(player: String, num: Int) {
        if (num == 0)
        {
            var img = self.getPlayer(player: player)
            img.alpha = 0.0
            
         
            
            
            UIView.beginAnimations("Fade", context: nil)
            UIView.beginAnimations("Move", context: nil)
            
            
            UIView.setAnimationDuration(6.5)
            
            UIView.setAnimationDelegate(self)
            self.lionX = Int(self.lionFrame.origin.x)
            
            self.lionY = Int(self.lionFrame.origin.y)
            
            self.lionImage.frame = self.lionFrame;
            
            
            img.alpha = 1.0
            
            UIView.commitAnimations()
            
        }
        
        
        if (num == 1)
        {
            
            var img = self.getPlayer(player: player)
            img.alpha = 0.0
            
            
            UIView.beginAnimations("Fade", context: nil)
            UIView.beginAnimations("Move", context: nil)
            
            
            UIView.setAnimationDuration(6.5)
            
            UIView.setAnimationDelegate(self)
            self.cobraX = Int(self.cobraFrame.origin.x)
            
            self.cobraY = Int(self.cobraFrame.origin.y)
            
            self.cobraImage.frame = self.cobraFrame;
            
            
            img.alpha = 1.0
            
            UIView.commitAnimations()
            
            
        }
        
        
        if (num == 2)
        {
            var img = self.getPlayer(player: player)
            img.alpha = 0.0
            
            
            UIView.beginAnimations("Fade", context: nil)
            UIView.beginAnimations("Move", context: nil)
            
            
            UIView.setAnimationDuration(6.5)
            
            UIView.setAnimationDelegate(self)
            self.rabbitX = Int(self.rabbitFrame.origin.x)
            
            self.rabbitY = Int(self.rabbitFrame.origin.y)
            
            self.rabbitImage.frame = self.rabbitFrame;
            
            
            img.alpha = 1.0
            
            UIView.commitAnimations()
            
        }
        
    }
    
    //If conditionals for wins
    func goToPosWin(player: String, num: Int) {
        if (num == 0)
        {
            var img = self.getPlayer(player: player)

            
            UIView.beginAnimations("Fade", context: nil)
            UIView.beginAnimations("Move", context: nil)
            
            
            UIView.setAnimationDuration(6.5)
            
            UIView.setAnimationDelegate(self)
            self.lionX = Int(self.viewA.frame.origin.x)
            
            self.lionY = Int(self.viewA.frame.origin.y)
            
            self.lionImage.frame = self.viewA.frame;
            
            
            img.alpha = 1.0
            
            UIView.commitAnimations()
            
        }
        
        
        if (num == 1)
        {
            
            var img = self.getPlayer(player: player)
            
            UIView.beginAnimations("Fade", context: nil)
            UIView.beginAnimations("Move", context: nil)
            
            
            UIView.setAnimationDuration(6.5)
            
            UIView.setAnimationDelegate(self)
            self.cobraX = Int(self.viewA.frame.origin.x)
            
            self.cobraY = Int(self.viewA.frame.origin.y)
            
            self.cobraImage.frame = self.viewA.frame;
            
            
            img.alpha = 1.0
            
            UIView.commitAnimations()
            
            
        }
        
        
        if (num == 2)
        {
            var img = self.getPlayer(player: player)
           
            UIView.beginAnimations("Fade", context: nil)
            UIView.beginAnimations("Move", context: nil)
            
            
            UIView.setAnimationDuration(6.5)
            
            UIView.setAnimationDelegate(self)
            self.rabbitX = Int(self.viewA.frame.origin.x)
            
            self.rabbitY = Int(self.viewA.frame.origin.y)
            
            self.rabbitImage.frame = self.viewA.frame;
            
            
            img.alpha = 1.0
            
            UIView.commitAnimations()
            
        }
        
    }
    
    // if conditionals for loses
    func goToPosLose(enemy: String, num: Int) {
        if (num == 0)
        {
          
            //   UIView.beginAnimations("Fade", context: nil)
            UIView.beginAnimations("Move", context: nil)
            
            
            UIView.setAnimationDuration(6.5)
            
            UIView.setAnimationDelegate(self)
         
            self.viewA.frame = self.lionImage.frame;
            
            
            // img.alpha = 1.0
            
            UIView.commitAnimations()
            
        }
        
        
        if (num == 1)
        {
            
            
            //  UIView.beginAnimations("Fade", context: nil)
            UIView.beginAnimations("Move", context: nil)
            
            
            UIView.setAnimationDuration(6.5)
            
            UIView.setAnimationDelegate(self)
            // self.cobraX = Int(self.cobraImage.frame.origin.x)
            
            //    self.cobraY = Int(self.cobraImage.frame.origin.y)
            
            self.viewA.frame = self.cobraImage.frame;
            
            
            
            
            UIView.commitAnimations()
            
            
        }
        
        
        if (num == 2)
        {
            
            
            //   UIView.beginAnimations("Fade", context: nil)
            UIView.beginAnimations("Move", context: nil)
            
            
            UIView.setAnimationDuration(6.5)
            
            UIView.setAnimationDelegate(self)
         
            
            self.viewA.frame = self.rabbitImage.frame;
            
            
            
            
            UIView.commitAnimations()
            
        }
        
    }
    
    
    
    //return to orgin
    func returnToOriginalPos () {
        
        if (cobraTouch == true)
        {
            UIView.beginAnimations("Move", context: nil)
            UIView.setAnimationDuration(6.5)
            UIView.setAnimationDelegate(self)
            cobraX = Int(cobraFrame.origin.x)
            
            cobraY = Int(cobraFrame.origin.y)
            
            cobraImage.frame = cobraFrame;
            
            UIView.commitAnimations()
            
        }
        
        
        if (rabitTouch == true)
        {
            
            UIView.beginAnimations("Move", context: nil)
            UIView.setAnimationDuration(6.5)
            UIView.setAnimationDelegate(self)
            rabbitX = Int(lionFrame.origin.x)
            
            rabbitY = Int(rabbitFrame.origin.y)
            
            rabbitImage.frame = rabbitFrame;
            
            
            UIView.commitAnimations()
            
        }
        
        
        if (lionMoved == true)
        {
            UIView.beginAnimations("Move", context: nil)
            UIView.setAnimationDuration(6.5)
            UIView.setAnimationDelegate(self)
            lionX = Int(lionFrame.origin.x)
            
            lionY = Int(lionFrame.origin.y)
            
            lionImage.frame = lionFrame;
            //top.alpha = 0;
            
            UIView.commitAnimations()
            
        }
        
        
        
    }
    
    
    
    //calculates time fired
    func timerFired() {
        
        titleImage.alpha = 1.0
        
        UIView.beginAnimations("Fade", context: nil)
        
        
        UIView.setAnimationDuration(6.5)
        
        UIView.setAnimationDelegate(self)
        
        
        titleImage.alpha = 0.0
        UIView.commitAnimations()
    
    }
    
    //fades out images
    func fadeOutB(image: UIImage, playerStr: String) {
        
        if(playerStr == "rabbit") {
            
            var flipped = UIImage(cgImage: (image.cgImage)!, scale: (image.scale), orientation: UIImageOrientation.upMirrored)
            
            let player = getPlayer(player: playerStr)
            
            player.alpha = 1.0
            
            
            player.image = flipped
            
            
            UIView.beginAnimations("Fade", context: nil)
            
            
            UIView.setAnimationDuration(6.5)
            
            UIView.setAnimationDelegate(self)
            
            
            player.alpha = 0.0
            UIView.commitAnimations()
            
        } else {
            
            let player = getPlayer(player: playerStr)
            
            player.alpha = 1.0
            
            
            player.image = image
            
            
            UIView.beginAnimations("Fade", context: nil)
            
            
            UIView.setAnimationDuration(6.5)
            
            UIView.setAnimationDelegate(self)

            
            
            player.alpha = 0.0
            UIView.commitAnimations()
        }
        
    }
    
    //fades out A
    func fadeOutA(image: UIImage) {
        
        viewA.alpha = 1.0
        
        
        viewA.image = image
        
        
        UIView.beginAnimations("Fade", context: nil)
        
        
        UIView.setAnimationDuration(6.5)
        
        UIView.setAnimationDelegate(self)
     
        viewA.alpha = 0.0
        UIView.commitAnimations()
        
    }
    //Fades in Images
    func fadeIn(image: UIImage) {
        
        viewA.alpha = 0.0
        
        
        viewA.image = image
        
        
        UIView.beginAnimations("Fade", context: nil)
        
        
        UIView.setAnimationDuration(6.5)
        
        UIView.setAnimationDelegate(self)

        
        
        viewA.alpha = 1.0
        UIView.commitAnimations()
    }
    
    //draws to complete rectangle
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        
        
        let ctx = UIGraphicsGetCurrentContext()
        
        ctx!.setStrokeColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1);
        ctx?.stroke(CGRect(x: backgroundImage.frame.origin.x, y: backgroundImage.frame.origin.y, width: backgroundImage.bounds.width, height: backgroundImage.bounds.height));
        
        self.lionImage.frame = CGRect(x: CGFloat(self.lionX), y: CGFloat(self.lionY), width: self.lionImage.frame.size.width, height: self.lionImage.frame.size.height);
        
        
        self.cobraImage.frame = CGRect(x: CGFloat(self.cobraX), y: CGFloat(self.cobraY), width: self.cobraImage.frame.size.width, height: self.cobraImage.frame.size.height);
        
        self.rabbitImage.frame = CGRect(x: CGFloat(self.rabbitX), y: CGFloat(self.rabbitY), width: self.rabbitImage.frame.size.width, height: self.rabbitImage.frame.size.height);
        
        
        self.viewA.frame = CGRect(x: CGFloat(self.viewAX), y: CGFloat(self.viewAY), width: self.viewA.frame.size.width, height: self.viewA.frame.size.height);
        
    }
    
    
    
}
