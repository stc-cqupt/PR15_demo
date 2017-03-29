function [G1 G2 G3] = compute_LOG(Gray,F)

     Gray = (Gray-mean2(Gray))/std2(Gray);
     %     figure, imshow(Gray,[]), 
     G1 = conv2(Gray,F(:,:,4),'same');
     G2 = conv2(Gray,F(:,:,5)','same');
     G3 = conv2(Gray,F(:,:,6)','same');
