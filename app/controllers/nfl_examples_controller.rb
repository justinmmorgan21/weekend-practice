class NflExamplesController < ApplicationController

  # class Player
  #   attr_accessor :name, :team, :position, :points
  #   def initialize(name, team, position, points)
  #     @name = name
  #     @team = team
  #     @position = position
  #     @points = points
  #   end
  #   def to_s
  #     "#{@name}\t\t#{@team}\t\t#{@position}\t\t#{@points}"
  #   end
  #   def create
  #     Player.create(name: "#{@name}", team: "#{@team}", position: "#{@position}", fantasy_pts_projected: @points)
  #   end
  # end

  def intermediate_example
    # Start with an array of numbers and create a new array with each number times 3.
    # For example, [1, 2, 3] becomes [3, 6, 9].
    arr = [9, 8, 7]
    arr.map! { |num| num * 3 }

    # Start with an array of strings and create a new array with each string upcased.
    # For example, ["hello", "goodbye"] becomes ["HELLO", "GOODBYE"].
    arr = ["hello", "goodbye"]
    arr.map! { |str| str.upcase }

    # Start with an array of hashes and create a new array of string values from each hash's :name key.
    # For example, [{name: "Alice", age: 27}, {name: "Blane", age: 16}] becomes ["Alice", "Blane"].
    arr = [{name: "Alice", age: 27}, {name: "Blane", age: 16}]
    arr.map! { |hash|
      hash[:name]
    }

    # Start with an array of numbers and create a new array with each number plus 7.
    # For example, [1, 2, 3] becomes [8, 9, 10].
    arr = [1, 2, 3]
    arr.map! { |num| num + 7}

    # Start with an array of strings and create a new array with each string's length.
    # For example, ["hello", "goodbye"] becomes [5, 7].
    arr = ["hello", "goodbye"]
    arr.map! { |str| str.length}

    # Start with an array of hashes and create a new array of number values from each hash's :age key.
    # For example, [{name: "Alice", age: 27}, {name: "Blane", age: 16}] becomes [27, 16].
    arr = [{name: "Alice", age: 27}, {name: "Blane", age: 16}]
    arr.map! { |hash| hash[:age]}

    # Start with an array of numbers and create a new array with each number divided by 2.
    # For example, [1, 2, 3] becomes [0.5, 1.0, 1.5].
    arr = [1, 2, 3]
    arr.map! { |num| num / 2.0}

    # Start with an array of strings and create a new array with each string's first letter only.
    # For example, ["hello", "goodbye"] becomes ["h", "g"].
    arr = ["hello", "goodbye"]
    arr.map! { |str| str[0]}

    # Start with an array of hashes and create a new array of number values from each hash's :age key times 2.
    # For example, [{name: "Alice", age: 27}, {name: "Blane", age: 16}] becomes [54, 32].
    arr = [{name: "Alice", age: 27}, {name: "Blane", age: 16}]
    arr.map! { |hash| hash[:age] * 2}

    # Start with an array of numbers and create a new array with each number converted into a string.
    # For example, [1, 2, 3] becomes ["1", "2", "3"].
    arr = [1, 2, 3]
    arr.map! { |num| num.to_s}

    render json: { json_response: "#{arr}" }
  end

  def upload_fantasy_projections
    
    require 'uri'
    require 'net/http'
    require 'json'
    
    url = URI("https://tank01-nfl-live-in-game-real-time-statistics-nfl.p.rapidapi.com/getNFLProjections?week=season&archiveSeason=2024&twoPointConversions=2&passYards=.04&passAttempts=-.5&passTD=4&passCompletions=1&passInterceptions=-2&pointsPerReception=1&carries=.2&rushYards=.1&rushTD=6&fumbles=-2&receivingYards=.1&receivingTD=6&targets=.1&fgMade=3&fgMissed=-1&xpMade=1&xpMissed=-1")
    
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    
    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = #API KEY HERE
    request["x-rapidapi-host"] = 'tank01-nfl-live-in-game-real-time-statistics-nfl.p.rapidapi.com'
    
    response = http.request(request)
    json_object = JSON.parse(response.read_body)

    # puts json_object["body"]["playerProjections"]

    json_object["body"]["playerProjections"].each { |player|
      data = player[1]
      puts "#{data["longName"]}: #{data["fantasyPoints"]}"
      puts
      Player.create(name: data["longName"], team: data["team"], position: data["pos"], fantasy_pts_projected: data["fantasyPoints"].to_f)
      
    }
    
    render json: {results: "finished uploading all players"}
  end

  def display_fantasy_projections
    
    require 'uri'
    require 'net/http'
    require 'json'
    
    url = URI("https://tank01-nfl-live-in-game-real-time-statistics-nfl.p.rapidapi.com/getNFLProjections?week=season&archiveSeason=2024&twoPointConversions=2&passYards=.04&passAttempts=-.5&passTD=4&passCompletions=1&passInterceptions=-2&pointsPerReception=1&carries=.2&rushYards=.1&rushTD=6&fumbles=-2&receivingYards=.1&receivingTD=6&targets=.1&fgMade=3&fgMissed=-1&xpMade=1&xpMissed=-1")
    
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    
    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = #API KEY HERE
    request["x-rapidapi-host"] = 'tank01-nfl-live-in-game-real-time-statistics-nfl.p.rapidapi.com'
    
    response = http.request(request)
    json_object = JSON.parse(response.read_body)

    puts json_object["body"]["playerProjections"]

    # json_object["body"]["playerProjections"].each { |player|
    #   data = player[1]
    #   puts "#{data["longName"]}: #{data["fantasyPoints"]}"
    #   puts
    # }
    
    render json: {results: "finished displaying all players"}
  end

  def get_player_by_id
    player = Player.find(params[:id])
    render json: {player: "#{player.name} --- #{player.team} --- #{player.position} --- #{player.fantasy_pts_projected}"}
  end

  def get_player_by_name
    player = Player.find_by(name: params[:name  ])
    render json: {player: "#{player.name} --- #{player.team} --- #{player.position} --- #{player.fantasy_pts_projected}"}
  end

  def add_player
    Player.create(name: params[:name], team: params[:team], position: params[:position], fantasy_pts_projected: params[:pts])
    render json: {update: "#{params[:name]} added."}
  end

  def remove_duplicates
    players = Player.all
    set = Set[]
    players.each { |player|
      if set.include?(player.name)
        player.destroy
        puts "destroyed duplicate #{player.name}"
      else
        set.add(player.name)
        puts "added unique #{player.name} to set"
      end
    }
    render json: {update: "Duplicates removed."}
  end

  def display_players
    render json: {players: Player.all}
    # positions = {
    #   QB: [],
    #   WR: [],
    #   RB: [],
    #   TE: []
    # }
    # json_object["body"]["playerProjections"].each { |player|
    #   data = player[1]
    #   player_obj = Player.new(data["longName"], data["team"], data["pos"], data["fantasyPoints"])
    #   case data["pos"]
    #     when "QB"
    #       positions[:QB] << player_obj
    #     when "WR"
    #       positions[:WR] << player_obj
    #     when "RB"
    #       positions[:RB] << player_obj
    #     when "TE"
    #       positions[:TE] << player_obj
    #   end
    # }
    
    # positions.each { |pos, players|  
    #   players.sort_by! { |player| player.points.to_f }.reverse!
    #   puts "**************************#{pos}***********************************"
    #   puts players
    # }
  end
end
