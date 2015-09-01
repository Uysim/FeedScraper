# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

w=Website.create(name: "CNET", link_url: "http://www.cnet.com")

# parrent selector
# s=w.selectors.new
# s.selector_type=Selector::TYPE[:type_parent]
# s.selector="body div#newsMenu div.menuWrapper"
# s.save

# w.selectors.create(selector: "nav .navWrapper li a", selector_type: Selector::TYPE[:type_element])
# w.selectors.create(selector: "body div#rbSkin div#rbContent div.row div.listing div.asset div.assetBody a", selector_type: Selector::TYPE[:content_link])
# w.selectors.create(selector: "body div#rbSkin div#rbContent div.row div.listing div.asset div.assetBody a", selector_type: Selector::TYPE[:content_title])
# w.selectors.create(selector: "body div#rbSkin div#rbContent div.row div.listing div.asset div.assetBody a", selector_type: Selector::TYPE[:content_image])
# w.selectors.create(selector: "body div#rbSkin div#rbContent div.row div.listing div.asset div.assetBody a", selector_type: Selector::TYPE[:content_body])

w.selectors.create([
  {:selector_type=>"Parent", :selector=>"body div#newsMenu div.menuWrapper"},
  {:selector_type=>"Element", :selector=>"nav .navWrapper li a"},
  {:selector_type=>"Content Link", :selector=>"body div#rbSkin div#rbContent div.row section.listing div.asset div.assetBody a"},
  {:selector_type=>"Content Title", :selector=>"body div#rbContent div.pageContainer div.container div.articleHead h1"},
  {:selector_type=>"Content Image", :selector=>"body div#rbContent div.pageContainer div#rbSkin div.articleContent div.article-main-body figure.image span.imageContainer img"},
  {:selector_type=>"Content Body", :selector=>"body div#rbContent div.pageContainer div#rbSkin div.articleContent article#article-body div.article-main-body p"}
])

# body article#article-body span.credit
w.remove_selectors.create(selector: 'body article#article-body span.credit', selector_page: 'Content Page')