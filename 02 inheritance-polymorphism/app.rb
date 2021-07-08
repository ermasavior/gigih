require_relative 'player'
require_relative 'hero'
require_relative 'villain'

jin = Hero.new("Jin Sakai", 10, 50, 0)
yuna = Hero.new("Yuna", 9, 45, 0)
ishihara = Hero.new("Sensei Ishihara", 8, 60, 0)
heroes = [jin, yuna, ishihara]

archer = MongolArcher.new("Mongol Archer", 80, 40, 0.5)
spearman = MongolSpearman.new("Mongol Spearman", 120, 60, 0.5)
swordsman = MongolSwordsman.new("Mongol Swordsman", 100, 50, 0.5)
villains = [archer, spearman, swordsman]

def print_players(heroes, villains)
    heroes.each do |hero|
        puts hero
    end
    puts
    villains.each do |villain|
        puts villain
    end
end

def choose_action_as_jin
    puts "As Jin Sakai, what do you want to do this turn?"
    puts "1) Attack an enemy"
    puts "2) Heal an ally"
    gets.chomp.to_i
end

def main_hero_attacks_an_enemy(main_hero, villains)
    puts "Which enemy you want to attack"
    i = 1
    villains.each do |villain|
        puts "#{i}) #{villain.name}"
        i += 1
    end

    idx = gets.chomp.to_i - 1
    villain = villains[idx]
    main_hero.attack(villain)
    villains.delete_at(idx) if villain.flee? || villain.dead?
end

def main_hero_heals_an_ally(main_hero, heroes)
    allies = []
    heroes.each { |hero| allies.push(hero) if hero != main_hero }
    return if allies.empty?

    puts "Which ally you want to heal"
    i = 1
    allies.each do |ally|
        puts "#{i}) #{ally.name}"
        i += 1
    end

    idx = gets.chomp.to_i - 1
    main_hero.heal(allies[idx])
end

def allies_attack_villains(main_hero, heroes, villains)
    allies = []
    heroes.each { |hero| allies.push(hero) if hero != main_hero }

    allies.each do |ally|
        hero_attack_random_villains(ally, villains)
        break if villains.empty?
    end
end

def hero_attack_random_villains(hero, villains)
    idx = rand(0..villains.length() - 1)
    villain = villains[idx]
    hero.attack(villain)

    villains.delete_at(idx) if villain.flee? || villain.dead?
end

def villains_attack_heroes(villains, heroes)
    villains.each do |villain|
        idx = rand(0..heroes.length() - 1)
        hero = heroes[idx]
        villain.attack(hero)

        heroes.delete_at(idx) if hero.dead?
        break if heroes.empty?
    end
end

turn = 1

loop do
    puts "========= Turn #{turn} ========="
    puts

    print_players(heroes, villains)
    puts

    unless jin.dead?
        action = choose_action_as_jin
        puts

        main_hero_attacks_an_enemy(jin, villains) if action == 1
        main_hero_heals_an_ally(jin, heroes) if action == 2
        break if villains.empty?
        puts
    end

    allies_attack_villains(jin, heroes, villains)
    break if villains.empty?
    puts

    villains_attack_heroes(villains, heroes)
    break if heroes.empty?
    puts

    puts heroes
    turn += 1
end

puts
if villains.empty?
    puts "========= Heroes are Win ========="
else
    puts "========= Heroes are Lose ========="
end