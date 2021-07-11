require_relative 'hero'

class MainHero < Hero
    def choose_action(villains, allies)
        puts "As Jin Sakai, what do you want to do this turn?"
        puts "1) Attack an enemy"
        puts "2) Heal an ally"
        action = gets.chomp.to_i

        if action == 1
            attack_an_enemy(villains)
        elsif action == 2 
            heal_an_ally(allies)
        end
        puts
    end

    private

        def attack_an_enemy(villains)
            puts "Which enemy you want to attack"
            villains.each_with_index do |villain, index|
                puts "#{index + 1}) #{villain.name}"
            end

            idx = gets.chomp.to_i - 1
            villain = villains[idx]
            attack(villain)

            villains.delete_at(idx) if villain.flee? || villain.dead?
        end

        def heal_an_ally(allies)
            puts "Which ally you want to heal"
            allies.each_with_index do |ally, index|
                puts "#{index + 1}) #{ally.name}"
            end

            idx = gets.chomp.to_i - 1
            heal(allies[idx])
        end
end
