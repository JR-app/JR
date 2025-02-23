import * as Location from 'expo-location'

export const getCurrentLocation = async (): Promise<null | Location.LocationObject> => {
	let { status } = await Location.requestForegroundPermissionsAsync();
	if (status !== 'granted') {
		console.log('Permission to access location was denied');
		return null;
	}

	let location = await Location.getCurrentPositionAsync({});
	console.log(location);
	return location;
}
