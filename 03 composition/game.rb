class Game
    def initialize(main_hero=Hero)
        @main_hero = main_hero
        @allies = []
        @villains = []
    end

    def add_ally(hero)
        @allies << hero
    end

    def add_villain(villain)
        @villains << villain
    end

    def start
        turn = 1
        until (@main_hero.dead? || @villains.empty?)
            puts "========= Turn #{turn} ========\n"

            print_player_stats
            @main_hero.choose_action(@villains, @allies)

            attack_villains
            attack_heroes

            turn += 1
        end
    end

    private

        def print_player_stats
            puts @main_hero
            @allies.each do |ally|
                puts ally
            end
            puts
            @villains.each do |villain|
                puts villain
            end
            puts
        end

        def attack_villains
            @allies.each do |ally|
                break if @villains.empty?

                villain = @villains[rand(@villains.size)]
                ally.attack(villain)
                @villains.delete(villain) if villain.flee? || villain.dead?
            end
            puts
        end

        def attack_heroes
            heroes = @allies + [@main_hero]

            @villains.each do |villain|
                hero = heroes[rand(heroes.size)]
                villain.attack(hero)

                if hero.dead?
                    heroes.delete(hero)
                    @allies.delete(hero) unless hero == @main_hero
                end
                break if @main_hero.dead? || heroes.empty?
            end
            puts
        end
end
