


let skeleton = Enemy(health: 100, attackStrength: 15)

let dragon = Dragon()
dragon.wingSpan = 5
dragon.attackStrength = 15
dragon.move()
dragon.attack()
print(dragon.wingSpan)
dragon.talk(speech: "what's up, i'm a a dragon. i'll fuck you up")
dragon.move()
skeleton.move()
dragon.attack()


