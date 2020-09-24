


//This is the code for direction between two points
public PVector getDirectionBetween(PVector v1, PVector v2){
	return PVector.sub(v2, v1);
}

public PVector getDirectionNormalizedBetween(PVector v1, PVector v2){
	PVector v = PVector.sub(v2, v1);
	return v.normalize();
}

public float getSqrDistanceBetween(PVector v1, PVector v2){
	PVector v = PVector.sub(v2, v1);
	return v.magSq();
}

//This is the code for distance between two points
public float getDistanceBetween(PVector v1, PVector v2){
	return PVector.dist(v1,v2);
}
