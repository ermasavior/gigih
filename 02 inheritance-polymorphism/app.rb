require_relative 'player'
require_relative 'hero'
require_relative 'villain'

jin = Hero.new("Jin Sakai", 100, 50, 0.8)
yuna = Hero.new("Yuna", 90, 45, 0.8)
ishihara = Hero.new("Sensei Ishihara", 80, 60, 0.8)
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

def main_hero_heals_an_ally(main_hero, allies)
    puts "Which ally you want to heal"
    i = 1
    allies.each do |ally|
        puts "#{i}) #{ally.name}"
        i += 1
    end

    idx = gets.chomp.to_i - 1
    main_hero.heal(allies[idx])
end

def allies_attack_villains(allies, villains)
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
allies = []
heroes.each { |hero| allies.push(hero) if hero != jin }

loop do
    puts "========= Turn #{turn} ========="
    puts

    print_players(heroes, villains)
    puts

    action = choose_action_as_jin
    puts

    main_hero_attacks_an_enemy(jin, villains) if action == 1
    main_hero_heals_an_ally(jin, allies) if action == 2
    break if villains.empty?
    puts

    allies_attack_villains(allies, villains)
    break if villains.empty?
    puts

    villains_attack_heroes(villains, [jin] + allies)
    break if heroes.empty?
    puts

    turn += 1
end

puts
puts "========= Heroes are Lose =========" if heroes.empty?
puts "========= Heroes are Win =========" if villains.empty?