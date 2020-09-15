
//THX. "lordOfDuct"

//linePnt - point the line passes through
//lineDir - unit vector in direction of line, either direction works
//pnt - the point to find nearest on line for
PVector NearestPointOnLineRewritten(PVector lineStart, PVector lineDir, PVector vPoint)
{
	PVector lS = new PVector(lineStart.x, lineStart.y);
	PVector lDir = new PVector(lineDir.x, lineDir.y);
	PVector pnt = new PVector(vPoint.x, vPoint.y);

    lDir.normalize();//this needs to be a unit vector
    PVector v = pnt.sub(lS);
    //PVector v = lineStart.sub(point);
    float d = v.dot(lDir);
    line(lS.x + lDir.x * d, lS.y + lDir.y * d, lS.x + lDir.x * d, lS.y+200 + lDir.y * d);


    //return linePnt + lDir * d;
    //point on line
    lDir.mult(d);
    lS.add(lDir);
    return lS;
}
