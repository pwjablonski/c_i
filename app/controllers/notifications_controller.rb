class NotificationsController < ApplicationController
    before_filter :authenticate_user!
    helper_method :mailbox, :notification
    
    def trash
        notification.move_to_trash(current_user)
        redirect_to :notifications
    end
    
    def untrash
        notification.untrash(current_user)
        redirect_to :notifications
    end
    
    def show
        notification.mark_as_read(current_user)
    end
    
    
    def mark_as_read
        notification.mark_as_read(current_user)
        redirect_to :notifications
    end
    
    def mark_as_unread
        notification.mark_as_unread(current_user)
        redirect_to :notifications
    end

    
    private
    
    def mailbox
        @mailbox ||= current_user.mailbox
    end
    
    
    def notification
        @notification ||= mailbox.notifications.find(params[:id])
    end
    
    
    
end
