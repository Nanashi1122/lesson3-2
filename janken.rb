hands = ["グー","チョキ","パー"]
hands_bit = [9,18,4] #2進数 [01001,10010,00100]

puts "最初はグー、じゃんけん..."

def hand_select()
  loop do
    puts "出す手を選択"
    puts "1(グー)、2(チョキ)、3(パー)"
    select_hand = gets.to_i
    if select_hand < 1 || 3 < select_hand then
      puts "無効な値です"
      next 
    else
      return select_hand - 1
    end
  end
end

def direction_select(move,game_direction)
  directions = ["上","下","左","右"]
  loop do
    puts "#{move}方向を選択"
    puts "1(上)、2(下)、3(左)、4(右)"
    player_direction = gets.to_i
    if player_direction < 1 || 4 < player_direction then
      puts "無効な値です"
      next 
    else
      player_direction -= 1
      puts "ホイ！"
      puts "あなた：#{directions[player_direction]}"
      puts "相手：#{directions[game_direction]}"
      if player_direction == game_direction then
        return 1
      else
        return 0
      end
    end
  end
end

def direction_game(num) # 0.プレイヤー側勝ち 1.ゲーム側勝ち
  game_direction = rand(4)
  puts "\nあっち向いて..."
  case num
  when 0
    result = direction_select("指をさす",game_direction)
    if result == 1 then
      puts "あなたの勝ちです！！！"
      exit
    end
  when 1
    result = direction_select("顔を向ける",game_direction)
    if result == 1 then
      puts "あなたの負けです..."
      exit
    end
  end
end

loop do
  player_hand = hand_select()
  game_hand = rand(3)
  puts "あなた：#{hands[player_hand]}"
  puts "相手：#{hands[game_hand]}"
  if (hands_bit[player_hand] & (hands_bit[game_hand] << 2)) > 0 then #左に2シフトさせた値の論理積が0以上
    direction_game(0)
    puts "\nじゃんけん..."
  elsif (hands_bit[player_hand] & (hands_bit[game_hand] << 1)) > 0 then #左に1つシフトさせた値の論理積が0
    direction_game(1)
    puts "\nじゃんけん..."
  else
    puts "\nあいこで..."
  end
end