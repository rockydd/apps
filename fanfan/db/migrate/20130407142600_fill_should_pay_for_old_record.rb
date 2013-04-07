class FillShouldPayForOldRecord < ActiveRecord::Migration
  def up
    activities = Activity.find(:all)
    activities.each do |a|
      if a.payments.detect {|p| p.should_pay.nil?} 
        if a.payments.detect {|p| !p.should_pay.nil?}
          puts "activity #{a.subject}(id:#{a.id}) data corrupt, can't be updated. please check manually"
          exit 1
        end
        avg = a.cost / a.payments.size
        a.payments.each {|p| p.should_pay = avg;p.save}
      end
    end
  end

  def down
  end
end
