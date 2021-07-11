class Player
    attr_reader :name, :hitpoint

    def initialize(name, hitpoint, attack_damage)
        @name = name
        @hitpoint = hitpoint
        @attack_damage = attack_damage
    end
    
    def to_s
        "#{@name} has #{@hitpoint} hitpoint and #{@attack_damage} attack damage"
    end

    def attack(other_player)
        puts "#{@name} attacks #{other_player.name} with #{@attack_damage} damage"
        other_player.take_damage(@attack_damage)
    end

    def take_damage(attack_damage)
        @hitpoint -= attack_damage

        puts "#{@name} dies" if dead?
    end

    def dead?
        return false if @hitpoint > 0
        true
    end
end
