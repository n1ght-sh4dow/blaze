import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hunt Creatures'),
      ),
      body: Consumer<GameProvider>(
        builder: (context, gameProvider, _) {
          if (gameProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (gameProvider.currentLocation == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'Location Access Required',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enable location to start hunting',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // TODO: Implement Google Maps
              Container(
                height: 300,
                color: Colors.grey[300],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.map, size: 64),
                      const SizedBox(height: 16),
                      Text(
                        'Lat: ${gameProvider.currentLocation!.latitude!.toStringAsFixed(4)}',
                      ),
                      Text(
                        'Lon: ${gameProvider.currentLocation!.longitude!.toStringAsFixed(4)}',
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: gameProvider.nearbyTerritories.length,
                  itemBuilder: (context, index) {
                    final territory = gameProvider.nearbyTerritories[index];
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(territory.name),
                        subtitle: Text('Level ${territory.level}'),
                        trailing: ElevatedButton(
                          onPressed: () {
                            // TODO: Implement battle
                          },
                          child: const Text('Battle'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
