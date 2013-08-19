package com.ayone.atlas.util
{
	
import mx.collections.ArrayCollection;
	
public class VectorUtil
{
	//------------------------------------------------------------
	//
	// Methods
	//
	//------------------------------------------------------------
	
	public static function vectorToArrayCollection(vector:Vector.<Object>):ArrayCollection
	{
		if (!vector)
			return null;
		
		var arrayCollection:ArrayCollection = new ArrayCollection();
		
		for each (var item:Object in vector)
			arrayCollection.addItem(item);
		
		return arrayCollection;
	}
	
	public static function arrayCollectionToVector(arrayCollection:ArrayCollection):Vector.<Object>
	{
		if (!arrayCollection)
			return null;
		
		var vector:Vector.<Object> = new Vector.<Object>();
			
		for (var i:int = 0; i < arrayCollection.length; i++)
		{
			vector.push(arrayCollection.getItemAt(i));
		}
		
		return vector;
	}
}

}