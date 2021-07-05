require_relative 'hero'

jin = Hero.new("Jin Sakai", 100, 50)
khotun = Player.new("Khotun Khan", 500, 50)

puts jin
puts
puts khotun
puts

loop do
    jin.attack(khotun)
    puts khotun
    puts
    break if khotun.dead?

    khotun.attack(jin)
    puts jin
    puts
    break if jin.dead?
end
