function points = kinesthetic_teaching (M, dataset)

points   = [];
button = 1;
count = 1;

disp('Introduce points of the trajectory by clicking on the map.');
disp('To finish, press any other button than primary click.');

hold on;
imagesc(M');
if  ~numel(dataset)==0
plot(dataset(1,:), dataset(2,:),'.b');
end
axis image;
axis off;
colormap gray(256);

while button == 1
    [x, y, button] = ginput(1);
    x = round(x);
    y = round(y);
    if button == 1 
        if M(x,y)> 0  % Avoid to save points in obstacles.
            points(:,count) = [x; y];
            plot(x,y,'.r');
            count = count + 1;
            if count > 2 % Avoid to save two equal points in the same demo.
                    if points(:,count-1) == points(:,count-2)
                        points(:,count-1) = [];
                        count = count - 1;
                        disp('Point repeated. Not memorized..');
                    end
            end
        else
            disp('Warning: point is in an obstacle. Not memorized.');
        end
    end
end