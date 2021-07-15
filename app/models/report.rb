class Report < ApplicationRecord


	has_one :admin

	enum status: { pending: 0 , inprogress: 1 , completed: 2, rejected: 3}

	enum vtype: { "Domestic violence": 0 , "Sexual harassment": 1 , "Sexual assualt": 2, "Cyber harassment": 3}


	has_many_attached :images
	has_many_attached :videos
	validates :name, presence: true
	validates :email, presence: true
	validates :phone, presence: true, format: { with: /([1|7]{1})+([6|7]{1})+([0-9]{6})/, 
    message: "Enter correct phone number format" }
	validates :address, presence: true
	validates :vtype, presence: true
	validate :image_type
	validate :video_type


	private
	def image_type
		if images.attached? == true
			images.each do |image|
				if !image.content_type.in?(%('image/jpeg image/png'))
					errors.add(:images, "Needs to be an image file")
				end
			end
		end
	end

	private
	def video_type
		if videos.attached? == true
			videos.each do |video|
				if !video.content_type.in?(%('video/mp4 video/mov video/avi video/wmv'))
					errors.add(:videos, "Needs to be a video file")
				end
			end
		end
	end

	# def thumbnail input
	# 	return self.images[input].variant(resize: '300*300!').processed
	# end
end
