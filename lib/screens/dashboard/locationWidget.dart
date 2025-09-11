import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucus/utility/appSize.dart';
import '../../notifier/locationNotifier.dart';
import '../../utility/appColor.dart';

class LocationWidget extends ConsumerWidget {
  const LocationWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationNotifier);
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: locationState.isLoading
            ? const RefreshProgressIndicator()
            : locationState.error != null
                ? Text('Error: ${locationState.error}')
                : GestureDetector(
                    onTap: () {
                      ref.read(locationNotifier.notifier).fetchLocation();
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.primaryColor,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${locationState.location.pinCode}, ",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: AppSize.baseEx,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${locationState.location.street}, ${locationState.location.city}",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: AppSize.baseEx,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ));
  }
}
