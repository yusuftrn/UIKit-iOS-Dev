//
//  GameScene.swift
//  AngryKids
//
//  Created by Yusuf Turan on 27.06.2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
  
  struct Box {
    var box = SKSpriteNode()
    let boxTexture = SKTexture(imageNamed: "brick")
    
    init() {
      let size = CGSize(width: boxTexture.size().width/5, height: boxTexture.size().height/5)
      box.physicsBody = SKPhysicsBody(rectangleOf: size)
      box.physicsBody?.isDynamic = true
      box.physicsBody?.affectedByGravity = true
      box.physicsBody?.allowsRotation = true
      box.physicsBody?.mass = 0.1
      box.zPosition = 1
    }
  }
  
  var kid = SKSpriteNode()
  var boxes = Array(repeating: Box(), count: 5)
  
  
  var isGameStarted: Bool = false
  var kidsOriginalPositon: CGPoint?
  
  override func didMove(to view: SKView) {
    
    self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    self.scene?.scaleMode = .aspectFit
    
    kid = childNode(withName: "kid") as! SKSpriteNode
    let kidTexture = SKTexture(imageNamed: "kid")
    kid.physicsBody = SKPhysicsBody(circleOfRadius: kidTexture.size().height/10.5)
    kid.physicsBody?.affectedByGravity = false
    kid.physicsBody?.isDynamic = true
    kid.physicsBody?.mass = 0.3
    kid.zPosition = 1
    kidsOriginalPositon = kid.position

    
    for i in 0..<boxes.count {
      let count = i + 1
      boxes[i].box.childNode(withName: String(count))
    }
    
  }
  
  
  func touchDown(atPoint pos : CGPoint) {
    
  }
  
  func touchMoved(toPoint pos : CGPoint) {
    
  }
  
  func touchUp(atPoint pos : CGPoint) {
    
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    strainKid(touches, with: event)
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    impulseKid(touches, with: event)
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    
  }
  
  private func strainKid(_ touches: Set<UITouch>, with event: UIEvent?) {
    if !isGameStarted {
      if let touch = touches.first {
        let touchLocation = touch.location(in: self)
        let touchNodes = nodes(at: touchLocation)
        if !touchNodes.isEmpty {
          for node in touchNodes {
            if let sprite = node as? SKSpriteNode {
              if sprite == kid {
                kid.position = touchLocation
              }
            }
          }
        }
      }
    }
  }
  
  private func impulseKid(_ touches: Set<UITouch>, with event: UIEvent?) {
    if !isGameStarted {
      if let touch = touches.first {
        let touchLocation = touch.location(in: self)
        let touchNodes = nodes(at: touchLocation)
        if !touchNodes.isEmpty {
          for node in touchNodes {
            if let sprite = node as? SKSpriteNode {
              if sprite == kid {
                let dx = (touchLocation.x - kidsOriginalPositon!.x) * -9
                let dy = (touchLocation.y - kidsOriginalPositon!.y) * -9
                
                let impulse = CGVector(dx: dx, dy: dy)
                kid.physicsBody?.applyImpulse(impulse)
                kid.physicsBody?.affectedByGravity = true
                self.isGameStarted = true
              }
            }
          }
        }
      }
    }
  }
  
  
  override func update(_ currentTime: TimeInterval) {
    if let kidPhysicsBody = kid.physicsBody {
      if kidPhysicsBody.velocity.dx <= 01 && kidPhysicsBody.velocity.dy <= 0.1 && kidPhysicsBody.angularVelocity <= 0.1 && isGameStarted {
        kid.physicsBody?.affectedByGravity = false
        kid.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        kid.physicsBody?.angularVelocity = 0
        kid.zPosition = 1
        kid.position = kidsOriginalPositon!
        isGameStarted = false
      }
    }
  }
}
