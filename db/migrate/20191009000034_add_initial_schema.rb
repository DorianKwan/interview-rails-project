class AddInitialSchema < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.string :nickname
      t.text :signature
      t.string :password_digest
      t.boolean :is_moderator, default: false
      t.timestamps
    end
    add_index :users, :email, unique: true

    create_table :categories do |t|
      t.string :name
      t.string :slug
      t.timestamps
    end
    add_index :categories, :slug, unique: true

    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :created_by
      t.integer :upvotes, default: 0
      t.references :category
      t.timestamps
    end

    create_table :post_comments do |t|
      t.text :content
      t.string :created_by
      t.references :post
      t.timestamps
    end

    create_table :comment_comments do |t|
      t.text :content
      t.string :created_by
      t.references :post_comment
      t.timestamps
    end

    create_table :friendly_id_slugs do |t|
      t.string   :slug,           :null => false
      t.integer  :sluggable_id,   :null => false
      t.string   :sluggable_type, :limit => 50
      t.string   :scope
      t.datetime :created_at
    end
    add_index :friendly_id_slugs, [:sluggable_type, :sluggable_id]
    add_index :friendly_id_slugs, [:slug, :sluggable_type], length: { slug: 140, sluggable_type: 50 }
    add_index :friendly_id_slugs, [:slug, :sluggable_type, :scope], length: { slug: 70, sluggable_type: 50, scope: 70 }, unique: true

  end
end
