$contracts = { petite: 10, 
              pousse: 20, 
              garde: 40, 
              garde_sans: 80, 
              garde_contre: 160 }

$players = ['Krisztina', 'Abbe', 'Ben', 'Mathieu']

$scores = Hash.new($players.length)
$players.each do |player|
  $scores[player] = 0
end


def countPoints(deal_)
  points = deal_[:diff]
  if points >= 0 
    points += $contracts[deal_[:contract]]
  else
    points -= $contracts[deal_[:contract]]
  end
  $players.each do | player |
    if player == deal_[:lead]
      factor = $players.length - 1 
      if deal_.has_key? :partner 
        factor -= 2
      end
      $scores[player] += factor * points
    elsif player == deal_[:partner]
      $scores[player] += points
    else
      $scores[player] -= points
    end
  end
end

if false
  deal = { lead: 'Krisztina', contract: :petite, diff: 30 }
  print deal, "\n"
  countPoints(deal)
  print $scores, "\n"

  deal[:partner] = 'Abbe'

  countPoints(deal)
  print deal, "\n"
 
  print $contracts["petite".to_sym]
else

print $scores, "\n"
while(true) do
  puts "New round starting..."
  puts "Who won the bidding?"
  lead = gets.chomp
  puts "What contract?"
  contract = gets.chomp
  puts "What is the partner's name (blank if none)?"
  partner = gets.chomp
  puts "How many points?"
  diff = gets.chomp
  
  deal = Hash.new
  deal[:lead] = lead
  deal[:contract] = contract.tr(' ', '_').to_sym
  if !partner.empty?
    deal[:partner] = partner
  end
  deal[:diff] = diff.to_i
  print deal, "\n"
  countPoints deal
  print $scores, "\n"
end

end
