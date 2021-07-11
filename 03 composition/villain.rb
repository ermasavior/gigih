require_relative 'player'

class Villain < Player
    def initialize(name, hitpoint, attack_damage, flee_percentage)
        super(name, hitpoint, attack_damage)
        @flee_percentage = flee_percentage
        @fled = false
    end

    def take_damage(attack_damage)
        super(attack_damage)
        if @hitpoint <= 50 && @hitpoint > 0
            n = 10
            flee if rand(n) <= @flee_percentage * n
        end
    end

    def flee
        @fled = true
        puts "#{@name} has fled from the battlefield with #{@hitpoint} hitpoint left"
    end

    def flee?
        @fled
    end
end

class MongolArcher < Villain
    def attack(other_player)
        puts "#{@name} shoots an arrow at #{other_player.name} with #{@attack_damage} damage"
        other_player.take_damage(@attack_damage)
    end
end

class MongolSpearman < Villain
    def attack(other_player)
        puts "#{@name} thrusts #{other_player.name} with #{@attack_damage} damage"
        other_player.take_damage(@attack_damage)
    end
end

class MongolSwordsman < Villain
    def attack(other_player)
        puts "#{@name} slashes #{other_player.name} with #{@attack_damage} damage"
        other_player.take_damage(@attack_damage)
    end
end
