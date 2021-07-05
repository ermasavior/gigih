require_relative 'player'

class Hero < Player
    def take_damage(attack_damage)
        if can_deflect?
            puts "#{name} deflects the attack"
        else
            super(attack_damage)
        end
    end

    def can_deflect?
        rand(100) <= 80
    end
end
