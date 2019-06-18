function edge_magnitude=tensorgrad(im)

	im = single(im) / 255;
	yfilter = fspecial('sobel');
	xfilter = yfilter';
	
	rx = imfilter(im(:,:,1), xfilter);
	gx = imfilter(im(:,:,2), xfilter);
	bx = imfilter(im(:,:,3), xfilter);
	
	ry = imfilter(im(:,:,1), yfilter);
	gy = imfilter(im(:,:,2), yfilter);
	by = imfilter(im(:,:,3), yfilter);
	
	Jx = rx.^2 + gx.^2 + bx.^2;
	Jy = ry.^2 + gy.^2 + by.^2;
	Jxy = rx.*ry + gx.*gy + bx.*by;

	D = sqrt(abs(Jx.^2 - 2*Jx.*Jy + Jy.^2 + 4*Jxy.^2));
	e1 = (Jx + Jy + D) / 2;
	%the 2nd eigenvalue would be:  e2 = (Jx + Jy - D) / 2;

	edge_magnitude = sqrt(e1);


%figure,imshow(edge_magnitude);