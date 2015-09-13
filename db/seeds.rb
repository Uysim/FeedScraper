# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

w=Website.create(name: "CNET", link_url: "http://www.cnet.com")

w.categories_selectors.create([
  { selector_type: CategoriesSelector::TYPE[:parent], selector: 'body div#newsMenu div.menuWrapper' },
  { selector_type: CategoriesSelector::TYPE[:element], selector: 'nav .navWrapper li a' }
])

w.list_selectors.create([
  { selector_type: ListSelector::TYPE[:parent], selector: 'body div#rbSkin div#rbContent div.row section.listing div.asset' },
  { selector_type: ListSelector::TYPE[:link_element], selector: 'div.assetBody a' },
  { selector_type: ListSelector::TYPE[:thumnail], selector: 'div.assetThumb img' },
  { selector_type: ListSelector::TYPE[:snippet], selector: 'div.assetBody a p.dek' }
])

w.content_selectors.create([
  { selector_type: ContentSelector::TYPE[:title], selector: 'body div#rbContent div.pageContainer div.container div.articleHead h1' },
  { selector_type: ContentSelector::TYPE[:parent], selector: 'body div#rbContent div.pageContainer div#rbSkin div.articleContent' },
  { selector_type: ContentSelector::TYPE[:image], selector: 'div.article-main-body figure.image img' },
  { selector_type: ContentSelector::TYPE[:paragraph], selector: 'article#article-body div.article-main-body p' },
  { selector_type: ContentSelector::TYPE[:head], selector: 'article#article-body div.article-main-body h3' },
  { selector_type: ContentSelector::TYPE[:head], selector: 'article#article-body div.article-main-body h4' },
  { selector_type: ContentSelector::TYPE[:head], selector: 'article#article-body div.article-main-body h5' }
])
# body article#article-body span.credit
w.remove_selectors.create([
  { selector: 'body article#article-body span.credit', selector_type: 'Content Page' },
  { selector: 'body article#article-body a.clickToEnlarge', selector_type: 'Content Page'},
  { selector: 'body article#article-body figure.image figcaption', selector_type: 'Content Page'}

])