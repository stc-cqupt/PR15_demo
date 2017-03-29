function [G1 G2 G3] = compute_gradient(Gray,F)

     Gray = (Gray-mean2(Gray))/std2(Gray);
     %     figure, imshow(Gray,[]), 
     Gx = conv2(Gray,F(:,:,1),'same');
     Gy = conv2(Gray,F(:,:,1)','same');
     G1 = sqrt(Gx.^2+Gy.^2); 
     Gx = conv2(Gray,F(:,:,2),'same');
     Gy = conv2(Gray,F(:,:,2)','same');
     G2 = sqrt(Gx.^2+Gy.^2);
     Gx = conv2(Gray,F(:,:,3),'same');
     Gy = conv2(Gray,F(:,:,3)','same');
     G3 = sqrt(Gx.^2+Gy.^2);