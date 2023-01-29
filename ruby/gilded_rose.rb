class GildedRose

  def initialize(items)
    @items = items
  end

#   ========================    APPROACH #1 ==========================================
# Handling with multiple / chained if / else
# This is usually not recommended for the following reasons
# 1. if in future we have many cases and many new item type adding, Then the number of if / else will keep increasing
# 2. The code will become unmanageable
# 3. Making changes to the code (especially for a new dev coming in) would be difficult
# 4. Rubocop standards does not allow maintaining multiple if / else statements

  def update_quality()
    @items.each do |item|
      item.sell_in = item.sell_in - 1
      next if "Sulfuras" === item.name

      next if 0 === item.quality

      if "Aged Brie" === item.name
        item.quality += 1 if item.quality < 50
      elsif "Backstage passes" == item.name
        item.quality = if item.sell_in <= 0
          0
        elsif item.quality == 50
          item.quality
        elsif item.sell_in <= 5
          [(item.quality + 3), 50].min
        elsif item.sell_in <= 10
          [(item.quality + 2), 50].min
        else
          [(item.quality + 1), 50].min
        end
      else
        if item.sell_in <= 0
          item.quality = "Conjured" === item.name  ? item.quality / 4 : item.quality / 2
        else
          item.quality = item.quality - 1
        end
      end
    end
    puts @items.inspect
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

# # ======================== APPROACH 2 ==========================
# # Creating sub classes helps in code maintainability, SIngle Responsibility Principle
# # It helps if we need to more functionality for objects based on its type (name)

# class GildedRose

#   def initialize(items)
#     @items = items
#   end

#   def update_quality()
#     @items.each do |item|
#       item.sell_in = item.sell_in - 1

#       item.quality = item.update_quality
#     end
#   puts @items.inspect
#   end
# end

# class NormalItem < Item

#   def initialize(name, sell_in, quality)
#     super
#   end

#   def update_quality
#     if self.sell_in <= 0
#       self.quality / 2
#     else
#       self.quality - 1
#     end
#   end
# end

# class AgedBrie < Item

#   def initialize(name, sell_in, quality)
#     super
#   end

#   def update_quality
#     return self.quality if self.quality == 0 || self.quality == 50
#     self.quality + 1
#   end
# end

# class BackstagePasses < Item

#   def initialize(name, sell_in, quality)
#     super
#   end

#   def update_quality
#     return self.quality if self.quality == 0 || self.quality == 50
#     if self.sell_in <= 0
#       0
#     elsif self.quality == 50
#       self.quality
#     elsif self.sell_in <= 5
#       [(self.quality + 3), 50].min
#     elsif self.sell_in <= 10
#       [(self.quality + 2), 50].min
#     else
#       [(self.quality + 1), 50].min
#     end
#   end
# end

# class Sulfuras < Item

#   def initialize(name, sell_in, quality)
#     super
#   end

#   def update_quality
#     self.quality
#   end
# end

# class Conjured < Item

#   def initialize(name, sell_in, quality)
#     super
#   end

#   def update_quality
#     if self.sell_in <= 0
#       self.quality / 4
#     else
#       self.quality - 1
#     end
#   end
# end


# ================= TEST CASES FOR APPROACH #1 ====================

# items = [Item.new("Aged Brie", 5, 49)]
# items = [Item.new("Backstage passes", 5, 49)]
# items = [Item.new("Backstage passes", 5, 40)]
# items = [Item.new("Backstage passes", 10, 40)]
# items = [Item.new("Backstage passes", 10, 49)]
# items = [Item.new("Backstage passes", 25, 40)]
# items = [Item.new("Backstage passes", 25, 50)]
# items = [Item.new("Conjured", -2, 50)]
# items = [Item.new("Conjured", 10, 16)]
# items = [Item.new("ABC", 10, 16)]
# items = [Item.new("ABC", 10, 50)]
# items = [Item.new("ABC", 10, 0)]
# items = [Item.new("ABC", -10, 50)]

# ================ Test cases for APPROACH #2 ================================

# items = [AgedBrie.new(5, 49)]
# items = [AgedBrie.new("Aged Brie", 5, 50)]
# items = [AgedBrie.new("Aged Brie", 5, 40)]

# items = [BackstagePasses.new("Backstage passes", 5, 49)]
# items = [BackstagePasses.new("Backstage passes", 5, 40)]
# items = [BackstagePasses.new("Backstage passes", 10, 40)]
# items = [BackstagePasses.new("Backstage passes", 10, 49)]
# items = [BackstagePasses.new("Backstage passes", 25, 40)]
# items = [BackstagePasses.new("Backstage passes", 25, 50)]

# items = [Conjured.new("Conjured", -2, 16)]
# items = [Conjured.new("Conjured", 10, 16)]

# items = [NormalItem.new("Item", -2, 16)]
# items = [NormalItem.new("Conjured", 10, 16)]

# items = [Sulfuras.new("Sulfuras", 50, 80)]

# =========================================================================

# ======================= INVOKE FOR TESTING ==============================

GildedRose.new(items).update_quality
