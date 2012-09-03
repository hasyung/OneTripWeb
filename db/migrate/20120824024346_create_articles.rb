class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
    	t.references	:place,								:null => false
    	t.string			:title,								:null => false, :limit => 200
    	t.integer			:category_cd,					:null => false, :default => 0
    	t.string			:keywords,						:limit => 100
    	t.string			:description,					:limit => 100
    	t.string			:author,							:null => false, :limit => 100
    	t.text				:body,								:null => false
    	t.integer			:order,								:default => 0
      t.timestamps
    end
  end
end
