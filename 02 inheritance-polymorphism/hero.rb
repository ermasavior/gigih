require_relative 'player'

class Hero < Player
    attr_reader :healing_point

    def initialize(name, hitpoint, attack_damage, deflect_percentage)
        super(name, hitpoint, attack_damage)
        @deflect_percentage = deflect_percentage
        @healing_point = 20
    end

    def take_damage(attack_damage)
        super(attack_damage) if !deflect
    end

    def deflect
        n = 10
        if rand(n) <= @deflect_percentage * n
            puts "#{@name} deflects the attack"
            true
        end
    end

    def heal(ally)
        ally.get_healed(@healing_point)
        puts "#{@name} heals #{ally.name}, restoring #{@healing_point} hitpoint"
    end

    def get_healed(healing_point)
        @hitpoint += healing_point
    end
end
