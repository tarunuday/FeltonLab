clear;
clc;
g1=[,];
g2=[,];
h=[,];
file1='sample.mp4';
file2='sample.mp4';
v1 = VideoReader(file1);
v2 = VideoReader(file2);
minArea=300;
bwfilter=0.1;
%R=1,G=2,B=3;
color=3;
while (hasFrame(v1) && hasFrame(v2))
      data1 = readFrame(v1);
      img = imsubtract(data1(:,:,color), rgb2gray(data1)); 
      img = medfilt2(img, [3 3]);             
      img = im2bw(img,bwfilter);
      % Remov1e all those pixels less than 300px
      img = bwareaopen(img,minArea);
      % Label all the connected components in the image.
      bw = bwlabel(img, 8);
      % Here we do the image blob analysis.
      % We get a set of properties for each labeled region.
      stats1 = regionprops(bw,'Centroid');
      % This is a loop to bound the red objects in a rectangular box.
      
      data2= readFrame(v2);
      img = imsubtract(data2(:,:,color), rgb2gray(data2)); 
      img = medfilt2(img, [3 3]);             
      img = im2bw(img,bwfilter);
      % Remov1e all those pixels less than 300px
      img = bwareaopen(img,minArea);
      % Label all the connected components in the image.
      bw = bwlabel(img, 8);
      % Here we do the image blob analysis.
      % We get a set of properties for each labeled region.
      stats2 = regionprops(bw,'Centroid');
      
      for object = 1:min(length(stats1),length(stats2))
        bc1 = stats1(object).Centroid;
        bc2 = stats2(object).Centroid;
        g1=[g1;bc1];
        g2=[g2;bc2];
        h=[h;bc1(1),bc1(2),bc2(1)];
      end
      
      % PLOT 1
      subplot(2,2,1)
      imshow(data1)
      hold on
      title('x-y Plot')
      xlabel('x') % x-axis label
      ylabel('y') % y-axis label
      if(g1)  
          plot(g1(:,1),g1(:,2))
      end
      hold off
      drawnow
      
      %PLOT 2
      subplot(2,2,2)
      imshow(data2)
      hold on
      title('z-y Plot')
      xlabel('z') % x-axis label
      ylabel('y') % y-axis label
      if(g2)  
          plot(g2(:,1),g2(:,2))
      end
      hold off
      drawnow
      
      %PLOT 3D
      subplot(2,2,3)
      title('x-y-z Plot')
      xlabel('x') % x-axis label
      ylabel('y') % y-axis label
      zlabel('z') % z-axis label
      plot3(h(:,1),h(:,2),h(:,3))
      grid on;
end
