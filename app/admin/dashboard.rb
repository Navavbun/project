# frozen_string_literal: true

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "🛡️ Admins" do
          para "Total: #{Admin.count}"
          newest_admin = Admin.order(created_at: :desc).first
          para "Newest: #{newest_admin ? "##{newest_admin.id}: #{newest_admin.email}" : 'N/A'}"
          most_active_admin = Admin.column_names.include?("sign_in_count") ? Admin.order(sign_in_count: :desc).first : nil
          para "Most active: #{most_active_admin ? "##{most_active_admin.id}: #{most_active_admin.email}" : 'N/A'}"
        end
      end

      column do
        panel "💬 Discussions" do
          para "Total: #{Discussion.count}"
          most_commented = Discussion.left_joins(:comments).group(:id).order("COUNT(comments.id) DESC").first
          para "Most commented: #{most_commented ? "##{most_commented.id}: #{most_commented.topic} (#{most_commented.comments.count} comments)" : 'N/A'}"
          active_today = Discussion.where("created_at >= ?", Date.today)
          para "Active today: #{active_today.count}#{if active_today.first
                                                       " (e.g. ##{active_today.first.id}: #{active_today.first.topic})"
                                                     end}"
        end
      end

      column do
        panel "📝 Comments" do
          para "Total: #{Comment.count}"
          latest_comment = Comment.order(created_at: :desc).first
          para "Latest: #{latest_comment ? "##{latest_comment.id}: #{latest_comment.text.truncate(30)}" : 'N/A'}"
          para "Today: #{Comment.where(created_at: Date.today.all_day).count}"
          longest_comment = Comment.order(Arel.sql("LENGTH(text)")).last
          para "Longest: #{longest_comment ? "##{longest_comment.id}: #{longest_comment.text.truncate(30)}" : 'N/A'}"
        end
      end

      column do
        panel "🏷️ Tags" do
          para "Total: #{Tag.count}"
          most_used = Tag.left_joins(:discussion_tags).select("tags.*, COUNT(discussion_tags.id) as tags_count").group("tags.id").order("tags_count DESC").first
          para "Most used: #{most_used&.name || 'N/A'} (#{most_used&.discussion_tags&.size || 0} uses)"
          para "Unused: #{Tag.where.missing(:discussion_tags).count}"
        end
      end
    end

    panel "🔥 Trending Discussions" do
      trending = Discussion.left_joins(:comments)
                           .where(comments: { created_at: 7.days.ago..Time.current })
                           .select("discussions.*, COUNT(comments.id) as comments_count")
                           .group("discussions.id")
                           .order("comments_count DESC")
                           .limit(5)
      if trending.any?
        ul do
          trending.each do |d|
            li "🔥 ##{d.id}: #{d.topic} (#{d.comments.where(created_at: 7.days.ago..Time.current).count} comments this week)"
          end
        end
      else
        para "No trending discussions this week."
      end
    end

    panel "⏰ Recent Activity" do
      recent_comments = Comment.order(created_at: :desc).limit(5)
      if recent_comments.any?
        ul do
          recent_comments.each do |c|
            li "📝 ##{c.id}: #{c.text.truncate(40)} (on '#{c.discussion&.topic || 'N/A'}', #{c.created_at.strftime('%Y-%m-%d %H:%M')})"
          end
        end
      else
        para "No recent comments."
      end
    end
  end
end
