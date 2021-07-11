require_relative 'player'
require_relative 'hero'
require_relative 'main_hero'
require_relative 'villain'
require_relative 'game'

jin = MainHero.new("Jin Sakai", 100, 50, 0)
yuna = Hero.new("Yuna", 90, 45, 0)
ishihara = Hero.new("Sensei Ishihara", 80, 60, 0)

archer = MongolArcher.new("Mongol Archer", 80, 40, 0.5)
spearman = MongolSpearman.new("Mongol Spearman", 120, 60, 0.5)
swordsman = MongolSwordsman.new("Mongol Swordsman", 100, 50, 0.5)

game = Game.new(jin)
game.add_ally(yuna)
game.add_ally(ishihara)
game.add_villain(archer)
game.add_villain(spearman)
game.add_villain(swordsman)

game.start()
