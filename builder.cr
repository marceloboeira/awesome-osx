require "yaml"
require "file"

class Item
  YAML.mapping({
    name: String,
    description: String,
    url: String,
    price: String
  })
end

class Category
  YAML.mapping({
    name: String,
    description: String,
    items: Array(Item),
  })
end

class Builder
  YAML.mapping({
    categories: Array(Category)
  })
end


data = File.read("./data.yml")
builder = Builder.from_yaml(data)

content = ""

categories = builder.categories
categories.each do |category|
  content += "## #{category.name}\n"
  content += "> #{category.description}\n\n"
  items = category.items

  items.each do |item|
    content += "* [#{item.name}](#{item.url}) (#{item.price}) - #{item.description}\n"
  end

  content += "\n"
end

File.write("./ITEMS.md", content)
