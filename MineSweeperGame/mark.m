function mark(btn,eventdata,h) %%left_click
    xx=get(btn,'string');
    if isempty(xx) || xx=='?'
        set(btn,'string','X','foregroundcolor','r');
        
    end
end
