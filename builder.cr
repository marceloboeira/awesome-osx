require "yaml"
require "file"

data = File.read("./data.yml")
yaml = YAML.load(data)
content = ""

if yaml.is_a?(Hash)
  categories = yaml["categories"]
  if categories.is_a?(Array)
    categories.each do |category|
      if category.is_a?(Hash)
        content += "## #{category["name"]}\n"
        content += "> #{category["description"]}\n\n"

        items = category["items"]

        if items.is_a?(Array)
          items.each do |item|
            if item.is_a?(Hash)
              content += "* [#{item["name"]}](#{item["url"]}) (#{item["price"]}) - #{item["description"]}\n"
            end
          end
        end
      end
      content += "\n"
    end
  end
end

File.write("./ITEMS.md", content)
