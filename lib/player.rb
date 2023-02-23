require "json"
# class JSONable
#     def to_json(options={})
#         hash = {}
#         self.instance_variables.each do |var|
#             hash[var] = self.instance_variable_get var
#         end
#         hash.to_json
#     end
#     def from_json!(string)
#         JSON.load(string).each do |var, val|
#             self.instance_variable_set var, val
#         end
#     end
# end

class Player
    attr_accessor :name, :symbol

    def initialize(name, symbol)
        @name = name
        @symbol = symbol
    end


    def name
        @name
    end

    def symbol
        @symbol
    end


    def as_json(options={})
        {
          name: @name,
          symbol: @symbol
        }
      end
    
      def to_json(*options)
        as_json(*options).to_json(*options)
      end


end