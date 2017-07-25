clear bb bc data;
g=[,];
% For work with recorded videos
filename='red.mp4';
v = VideoReader(filename);
frameno = 1;                            % frame number=0;
while hasFrame(v)
      data= readFrame(v);
      img = imsubtract(data(:,:,1), rgb2gray(data)); 
      img = medfilt2(img, [3 3]);             
      img = im2bw(img,0.4);
      % Remove all those pixels less than 300px
      img = bwareaopen(img,700);
      % Label all the connected components in the image.
      bw = bwlabel(img, 8);
      % Here we do the image blob analysis.
      % We get a set of properties for each labeled region.
      stats = regionprops(bw,'Centroid','BoundingBox','Area');
      % This is a loop to bound the red objects in a rectangular box.
      for object = 1:length(stats)
        ba = stats (object).Area;
        bb = stats (object).BoundingBox;
        bc = stats (object).Centroid;
        rectangle('Position',bb,'EdgeColor','r','LineWidth',1)
        %plot(bc(1),bc(2), '-m+')
        a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), '    Y: ', num2str(round(bc(2))),'    Area: ', num2str(round(ba(1))), '   Frame: ', num2str(frameno)));
        set(a, 'FontName', 'Arial', 'FontSize', 12, 'Color', 'red');
        g=[g;bc];
      end
      imshow(data)      
      hold on
      plot(g(:,2),g(:,1))
      hold off;
      frameno=frameno+1;
end
