import rhinoscriptsyntax as rs

rotation = 90

strObjs = rs.GetObjects("select the block kind you wanna rotate", 0, True, True)
for strObj in strObjs:
    boxPts = rs.BoundingBox(strObj)
    pt = rs.VectorAdd(boxPts[0],boxPts[2])
    pt = rs.VectorScale(pt, 0.5)
    rs.RotateObject(strObj, pt, rotation)