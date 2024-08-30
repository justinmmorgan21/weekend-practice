class NflExamplesController < ApplicationController

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

  

end
