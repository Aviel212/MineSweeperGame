function [varargout]=minesweeper(varargin)
%initialization
clc
clear
close all

%declaration and initializing variables
h=struct; %%creates new struct

h.row=10; %%number of rows_boxes
h.column=10; %%number of columns_boxes 
h.iposx=400;h.iposy=100; %%position of the main figure
h.boxdim=[35 35]; %%box dimensions
h.gap=[0.5 0.5]; %%space between boxes
h.mine=imread(strcat('mine','.png')); %%picture for a mine

% initializing gui
%%(position=x,y,width,height)
h.main=figure('name','Aviel''s minesweeper','NumberTitle',...
    'off','Position',[h.iposx,h.iposy,(h.row+4)*h.boxdim(1),(h.column+4)*h.boxdim(2)]);
h.newgame=uicontrol(h.main,'style','pushbutton','position',...
    [h.boxdim(2)*3,h.boxdim(2)*(h.column+4)-35-15,100,35],'string','New Game','callback','minesweeper','tooltipstring','Newgame');
h.close=uicontrol(h.main,'style','pushbutton','position',...
    [h.boxdim(1)*(h.row+4)-h.boxdim(1)*3-100,h.boxdim(2)*(h.column+4)-35-15,100,35],...
    'string','Close','callback','close gcbf');

%%creates 12*12 GuiButtons while the outer 2 frames are hidden
for x=1:h.row+2
    for y=1:h.column+2
        h.box(y,x)=uicontrol(h.main,'style','pushbutton','FontWeight','bold','foregroundcolor','b','fontsize',12,...
            'position',[h.boxdim(1)*(x),h.boxdim(2)*(h.column+3-y),h.boxdim(1)-h.gap(1),h.boxdim(2)-h.gap(2)]);
        if x==1 || y==1 || x==h.row+2 || y==h.column+2
            set(h.box(y,x),'visible','off');
        end
    end
end

% initializing background to work like bomb placement
h.difficulty=0.65;
randMatrix=rand(h.row+2,h.column+2); %%creates random 12*12 matrix (0<value<1)
bomb=int8(h.difficulty*randMatrix); %%above 0.5 turns to 1

bomb(:,1)=zeros(h.row+2,1); %%sets first column to 0's
bomb(:,h.column+2)=zeros(h.row+2,1); %%sets last column to 0's
bomb(1,:)=zeros(1,h.column+2); %%sets first row to 0's
bomb(h.row+2,:)=zeros(1,h.column+2); %%sets last row to 0's

h.game=bomb*9; %%creates new matrix, wherever there is a mine there will be the num '9'

%%go through all real row boxes to check how many mines are around each box
for x=2:h.row+1 
    for y=2:h.column+1 %%go through all real column boxes 
        n=0;
        if bomb(x,y)==0
            if bomb(x-1,y-1)==1
                n=n+1;
            end
            if bomb(x-1,y)==1
                n=n+1;
            end
            if bomb(x-1,y+1)==1
                n=n+1;
            end
            if bomb(x,y-1)==1
                n=n+1;
            end
            if bomb(x,y+1)==1
                n=n+1;
            end
            if bomb(x+1,y-1)==1
                n=n+1;
            end
            if bomb(x+1,y)==1
                n=n+1;
            end
            if bomb(x+1,y+1)==1
                n=n+1;
            end
        h.game(x,y)=n;    
        end 
    end
end

%%defining callbacks
for ii=1:h.row+2
    for jj=1:h.column+2
        set(h.box(ii,jj),'callback',{'button',h},'buttondownfcn',{'mark',h});
    end
end
end