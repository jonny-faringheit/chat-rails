require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#masked_email" do
    it "masks email with local part longer than 4 characters" do
      expect(helper.masked_email("test@example.com")).to eq("test@example.com")  # 4 chars, no mask
      expect(helper.masked_email("johndoe@gmail.com")).to eq("jo***oe@gmail.com")
      expect(helper.masked_email("user123@gmail.com")).to eq("us***23@gmail.com")
      expect(helper.masked_email("administrator@domain.com")).to eq("ad*********or@domain.com")
    end

    it "does not mask email with local part of 4 characters or less" do
      expect(helper.masked_email("abcd@example.com")).to eq("abcd@example.com")
      expect(helper.masked_email("abc@example.com")).to eq("abc@example.com")
      expect(helper.masked_email("ab@example.com")).to eq("ab@example.com")
      expect(helper.masked_email("a@example.com")).to eq("a@example.com")
    end

    it "handles blank email" do
      expect(helper.masked_email("")).to eq("")
      expect(helper.masked_email(nil)).to eq("")
    end

    it "handles invalid email format" do
      expect(helper.masked_email("notemail")).to eq("notemail")
      expect(helper.masked_email("@example.com")).to eq("@example.com")
    end
  end
end
