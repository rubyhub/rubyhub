class CreateBlogPosts < ActiveRecord::Migration
  def self.up
    create_table :blog_posts do |t|
      t.belongs_to :blog
      t.string :title
      t.text :text
      t.string :url
      t.datetime :published_at

      t.timestamps
    end
  end

  def self.down
    drop_table :blog_posts
  end
end
