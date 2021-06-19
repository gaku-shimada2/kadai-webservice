class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                  uniqueness: { case_sensitive: false }
    validates :postalcode, presence: true,  format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
    validates :prefecture, presence: true,  length: { maximum: 10 }
    validates :address1, presence: true,  length: { maximum: 100 }
    validates :address2, length: { maximum: 100 }
    validates :tel,  presence: true, numericality: {only_integer: true}, length: { in: 10..11 }
    has_secure_password
    
    has_many :purchases
    
    has_many :likes
    has_many :list_of_likes,through: :likes, source: :product
    
    def like(product)
        self.likes.find_or_create_by(product_id: product.id)
    end

    def unlike(product)
        like = self.likes.find_by(product_id: product.id)
        like.destroy if like
    end

    def liking?(product)
        self.list_of_likes.include?(product)
    end        

end
