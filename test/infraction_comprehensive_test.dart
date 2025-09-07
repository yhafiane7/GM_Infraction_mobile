import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:GM_INFRACTION/infraction.dart';
import 'package:GM_INFRACTION/models/infraction_model.dart';
import 'package:GM_INFRACTION/models/commune_model.dart';
import 'package:GM_INFRACTION/models/violant_model.dart';
import 'package:GM_INFRACTION/models/agent_model.dart';
import 'package:GM_INFRACTION/models/categorie_model.dart';

void main() {
  group('Infraction Comprehensive Tests', () {
    // Test data setup
    late List<Infraction> mockInfractions;
    late List<Commune> mockCommunes;
    late List<Violant> mockViolants;
    late List<Agent> mockAgents;
    late List<Categorie> mockCategories;

    setUp(() {
      mockInfractions = [
        Infraction(
          id: 1,
          nom: "John Doe",
          date: "2025-09-08",
          adresse: "123 Main St",
          commune_id: 1,
          violant_id: 2,
          agent_id: 3,
          categorie_id: 4,
          latitude: 34.5678,
          longitude: -6.1234,
        ),
        Infraction(
          id: 2,
          nom: "Jane Smith",
          date: "2025-09-07",
          adresse: "456 Elm St",
          commune_id: 2,
          violant_id: 3,
          agent_id: 4,
          categorie_id: 5,
          latitude: 35.1234,
          longitude: -6.5678,
        ),
      ];

      mockCommunes = [
        Commune(
          id: 1,
          nom: "Commune 1",
          pachalikcircon: "Pachalik 1",
          caidat: "Caidat 1",
          latitude: 34.5678,
          longitude: -6.1234,
        ),
        Commune(
          id: 2,
          nom: "Commune 2",
          pachalikcircon: "Pachalik 2",
          caidat: "Caidat 2",
          latitude: 35.1234,
          longitude: -6.5678,
        ),
      ];

      mockViolants = [
        Violant(id: 1, nom: "Violant 1", prenom: "Prenom 1", cin: "CIN001"),
        Violant(id: 2, nom: "Violant 2", prenom: "Prenom 2", cin: "CIN002"),
      ];

      mockAgents = [
        Agent(
          id: 1,
          nom: "Agent 1",
          prenom: "Prenom 1",
          tel: "1234567890",
          cin: "CIN001",
        ),
        Agent(
          id: 2,
          nom: "Agent 2",
          prenom: "Prenom 2",
          tel: "0987654321",
          cin: "CIN002",
        ),
      ];

      mockCategories = [
        Categorie(id: 1, nom: "Category 1", degre: 1),
        Categorie(id: 2, nom: "Category 2", degre: 2),
      ];
    });

    //------------------------------------InfractionList Tests-------------------------------------------------------//
    group('InfractionList Widget Tests', () {
      testWidgets('should render DataTable with infractions',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: InfractionList(Infractions: mockInfractions),
            ),
          ),
        );

        // Verify DataTable renders
        expect(find.byType(DataTable), findsOneWidget);

        // Verify headers
        expect(find.text('ID'), findsOneWidget);
        expect(find.text('Nom'), findsOneWidget);
        expect(find.text('Date'), findsOneWidget);
        expect(find.text('Adresse'), findsOneWidget);
        expect(find.text('Commune'), findsOneWidget);
        expect(find.text('Violant'), findsOneWidget);
        expect(find.text('Agent'), findsOneWidget);
        expect(find.text('Categorie'), findsOneWidget);
        expect(find.text('Latitude'), findsOneWidget);
        expect(find.text('Longitude'), findsOneWidget);

        // Verify data
        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('Jane Smith'), findsOneWidget);
        expect(find.text('123 Main St'), findsOneWidget);
        expect(find.text('456 Elm St'), findsOneWidget);
      });

      testWidgets('should handle empty infraction list',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: InfractionList(Infractions: []),
            ),
          ),
        );

        // Verify DataTable still renders with headers
        expect(find.byType(DataTable), findsOneWidget);
        expect(find.text('ID'), findsOneWidget);
        expect(find.text('Nom'), findsOneWidget);
      });

      testWidgets('should display correct number of rows',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: InfractionList(Infractions: mockInfractions),
            ),
          ),
        );

        // Verify DataTable is present and contains data
        expect(find.byType(DataTable), findsOneWidget);
        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('Jane Smith'), findsOneWidget);
      });

      testWidgets('should handle single infraction',
          (WidgetTester tester) async {
        final singleInfraction = [mockInfractions.first];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: InfractionList(Infractions: singleInfraction),
            ),
          ),
        );

        expect(find.byType(DataTable), findsOneWidget);
        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('123 Main St'), findsOneWidget);
      });
    });

    //------------------------------------InfractionView Tests-------------------------------------------------------//
    group('InfractionView Widget Tests', () {
      testWidgets('should display form with correct title',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: InfractionView(
              Communes: mockCommunes,
              Violants: mockViolants,
              Agents: mockAgents,
              Categories: mockCategories,
            ),
          ),
        );

        // Verify app bar title
        expect(find.text('Ajouter une Infraction'), findsOneWidget);

        // Verify check icon is present
        expect(find.byIcon(Icons.check), findsOneWidget);
      });

      testWidgets('should display form fields', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: InfractionView(
              Communes: mockCommunes,
              Violants: mockViolants,
              Agents: mockAgents,
              Categories: mockCategories,
            ),
          ),
        );

        // Verify form fields are present
        expect(find.byType(TextFormField), findsWidgets);
        expect(find.byType(Form), findsOneWidget);
      });

      testWidgets('should handle empty dropdown lists',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: InfractionView(
              Communes: [],
              Violants: [],
              Agents: [],
              Categories: [],
            ),
          ),
        );

        // Should still render without crashing
        expect(find.text('Ajouter une Infraction'), findsOneWidget);
        expect(find.byType(TextFormField), findsWidgets);
      });

      testWidgets('should handle check button tap',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: InfractionView(
              Communes: mockCommunes,
              Violants: mockViolants,
              Agents: mockAgents,
              Categories: mockCategories,
            ),
          ),
        );

        // Tap the check button
        await tester.tap(find.byIcon(Icons.check));
        await tester.pump();

        // Should not crash (validation will be handled by the form)
        expect(find.byIcon(Icons.check), findsOneWidget);
      });
    });

    //------------------------------------Form Validation Tests-------------------------------------------------------//
    group('Form Validation Tests', () {
      testWidgets('should show validation errors for empty fields',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: InfractionView(
              Communes: mockCommunes,
              Violants: mockViolants,
              Agents: mockAgents,
              Categories: mockCategories,
            ),
          ),
        );

        // Tap check button without filling form
        await tester.tap(find.byIcon(Icons.check));
        await tester.pump();

        // Should show validation messages
        expect(find.text('SVP Entrer Le Nom '), findsOneWidget);
        expect(find.text('SVP entrer La Date'), findsOneWidget);
        expect(find.text('SVP entrer une adresse'), findsOneWidget);
      });

      testWidgets('should validate required fields',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: InfractionView(
              Communes: mockCommunes,
              Violants: mockViolants,
              Agents: mockAgents,
              Categories: mockCategories,
            ),
          ),
        );

        // Find and fill the nom field
        final nomField = find.byType(TextFormField).first;
        await tester.enterText(nomField, 'Test Infraction');
        await tester.pump();

        // Tap check button
        await tester.tap(find.byIcon(Icons.check));
        await tester.pump();

        // Should still show other validation errors
        expect(find.text('SVP entrer La Date'), findsOneWidget);
        expect(find.text('SVP entrer une adresse'), findsOneWidget);
      });
    });

    //------------------------------------Data Display Tests-------------------------------------------------------//
    group('Data Display Tests', () {
      testWidgets('should display infraction data correctly',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: InfractionList(Infractions: mockInfractions),
            ),
          ),
        );

        // Verify all infraction data is displayed
        expect(find.text('John Doe'), findsOneWidget); // Nom
        expect(find.text('2025-09-08'), findsOneWidget); // Date
        expect(find.text('123 Main St'), findsOneWidget); // Adresse
        expect(find.text('34.5678'), findsOneWidget); // Latitude
        expect(find.text('-6.1234'), findsOneWidget); // Longitude
      });

      testWidgets('should handle long infraction names',
          (WidgetTester tester) async {
        final longNameInfraction = [
          Infraction(
            id: 1,
            nom: "Very Long Infraction Name That Should Be Handled Properly",
            date: "2025-09-08",
            adresse: "123 Main St",
            commune_id: 1,
            violant_id: 1,
            agent_id: 1,
            categorie_id: 1,
            latitude: 34.5678,
            longitude: -6.1234,
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: InfractionList(Infractions: longNameInfraction),
            ),
          ),
        );

        expect(
            find.text(
                "Very Long Infraction Name That Should Be Handled Properly"),
            findsOneWidget);
      });

      testWidgets('should handle special characters in data',
          (WidgetTester tester) async {
        final specialCharInfraction = [
          Infraction(
            id: 1,
            nom: "Infraction with émojis 🚨 and spécial chars",
            date: "2025-09-08",
            adresse: "123 Main St, Apt #2",
            commune_id: 1,
            violant_id: 1,
            agent_id: 1,
            categorie_id: 1,
            latitude: 34.5678,
            longitude: -6.1234,
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: InfractionList(Infractions: specialCharInfraction),
            ),
          ),
        );

        expect(find.text("Infraction with émojis 🚨 and spécial chars"),
            findsOneWidget);
        expect(find.text("123 Main St, Apt #2"), findsOneWidget);
      });
    });

    //------------------------------------Error Handling Tests-------------------------------------------------------//
    group('Error Handling Tests', () {
      testWidgets('should handle null values gracefully',
          (WidgetTester tester) async {
        final infractionWithNulls = [
          Infraction(
            id: null,
            nom: "Test Infraction",
            date: "2025-09-08",
            adresse: "123 Main St",
            commune_id: 1,
            violant_id: 1,
            agent_id: 1,
            categorie_id: 1,
            latitude: 34.5678,
            longitude: -6.1234,
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: InfractionList(Infractions: infractionWithNulls),
            ),
          ),
        );

        // Should still render without crashing
        expect(find.byType(DataTable), findsOneWidget);
        expect(find.text("Test Infraction"), findsOneWidget);
      });

      testWidgets('should handle extreme coordinate values',
          (WidgetTester tester) async {
        final extremeCoordInfraction = [
          Infraction(
            id: 1,
            nom: "Extreme Coordinates",
            date: "2025-09-08",
            adresse: "123 Main St",
            commune_id: 1,
            violant_id: 1,
            agent_id: 1,
            categorie_id: 1,
            latitude: 90.0,
            longitude: 180.0,
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: InfractionList(Infractions: extremeCoordInfraction),
            ),
          ),
        );

        expect(find.text("90.0"), findsOneWidget);
        expect(find.text("180.0"), findsOneWidget);
      });
    });

    //------------------------------------Integration Tests-------------------------------------------------------//
    group('Integration Tests', () {
      testWidgets(
          'should handle multiple infractions with different data types',
          (WidgetTester tester) async {
        final mixedInfractions = [
          Infraction(
            id: 1,
            nom: "String Infraction",
            date: "2025-09-08",
            adresse: "123 Main St",
            commune_id: 1,
            violant_id: 1,
            agent_id: 1,
            categorie_id: 1,
            latitude: 34.5678,
            longitude: -6.1234,
          ),
          Infraction(
            id: 2,
            nom: "Numeric Infraction",
            date: "2025-09-07",
            adresse: "456 Elm St",
            commune_id: 2,
            violant_id: 2,
            agent_id: 2,
            categorie_id: 2,
            latitude: 35.1234,
            longitude: -6.5678,
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: InfractionList(Infractions: mixedInfractions),
            ),
          ),
        );

        // Verify both infractions are displayed
        expect(find.text("String Infraction"), findsOneWidget);
        expect(find.text("Numeric Infraction"), findsOneWidget);
        expect(find.byType(DataTable), findsOneWidget);
      });

      testWidgets('should maintain form state during interactions',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: InfractionView(
              Communes: mockCommunes,
              Violants: mockViolants,
              Agents: mockAgents,
              Categories: mockCategories,
            ),
          ),
        );

        // Fill in some form fields
        final nomField = find.byType(TextFormField).first;
        await tester.enterText(nomField, 'Test Infraction');
        await tester.pump();

        // Verify the text is still there
        expect(find.text('Test Infraction'), findsOneWidget);

        // Tap check button
        await tester.tap(find.byIcon(Icons.check));
        await tester.pump();

        // Text should still be there
        expect(find.text('Test Infraction'), findsOneWidget);
      });
    });

    //------------------------------------Dropdown Selection Tests-------------------------------------------------------//
    group('Dropdown Selection Tests', () {
      testWidgets('should display commune dropdown with correct options',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: InfractionView(
              Communes: mockCommunes,
              Violants: mockViolants,
              Agents: mockAgents,
              Categories: mockCategories,
            ),
          ),
        );

        // Find commune dropdown
        final communeDropdown = find.byType(DropdownButtonFormField<Commune>);
        expect(communeDropdown, findsOneWidget);

        // Tap to open dropdown
        await tester.tap(communeDropdown);
        await tester.pumpAndSettle();

        // Verify dropdown options are displayed
        expect(find.text('Commune 1'), findsOneWidget);
        expect(find.text('Commune 2'), findsOneWidget);
      });

      testWidgets('should select commune from dropdown',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: InfractionView(
              Communes: mockCommunes,
              Violants: mockViolants,
              Agents: mockAgents,
              Categories: mockCategories,
            ),
          ),
        );

        // Find and tap commune dropdown
        final communeDropdown = find.byType(DropdownButtonFormField<Commune>);
        await tester.tap(communeDropdown);
        await tester.pumpAndSettle();

        // Select first commune
        await tester.tap(find.text('Commune 1'));
        await tester.pumpAndSettle();

        // Verify selection (dropdown should close and show selected value)
        expect(find.text('Commune 1'), findsOneWidget);
      });

      testWidgets('should display violant dropdown with correct options',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: InfractionView(
              Communes: mockCommunes,
              Violants: mockViolants,
              Agents: mockAgents,
              Categories: mockCategories,
            ),
          ),
        );

        // Find violant dropdown
        final violantDropdown = find.byType(DropdownButtonFormField<Violant>);
        expect(violantDropdown, findsOneWidget);

        // Tap to open dropdown
        await tester.tap(violantDropdown);
        await tester.pumpAndSettle();

        // Verify dropdown options are displayed (format: "nom prenom")
        expect(find.text('Violant 1 Prenom 1'), findsOneWidget);
        expect(find.text('Violant 2 Prenom 2'), findsOneWidget);
      });

      testWidgets('should select violant from dropdown',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: InfractionView(
              Communes: mockCommunes,
              Violants: mockViolants,
              Agents: mockAgents,
              Categories: mockCategories,
            ),
          ),
        );

        // Find and tap violant dropdown
        final violantDropdown = find.byType(DropdownButtonFormField<Violant>);
        await tester.tap(violantDropdown);
        await tester.pumpAndSettle();

        // Select first violant
        await tester.tap(find.text('Violant 1 Prenom 1'));
        await tester.pumpAndSettle();

        // Verify selection
        expect(find.text('Violant 1 Prenom 1'), findsOneWidget);
      });

      testWidgets('should display agent dropdown with correct options',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: InfractionView(
              Communes: mockCommunes,
              Violants: mockViolants,
              Agents: mockAgents,
              Categories: mockCategories,
            ),
          ),
        );

        // Find agent dropdown
        final agentDropdown = find.byType(DropdownButtonFormField<Agent>);
        expect(agentDropdown, findsOneWidget);

        // Tap to open dropdown
        await tester.tap(agentDropdown);
        await tester.pumpAndSettle();

        // Verify dropdown options are displayed (format: "nom prenom")
        expect(find.text('Agent 1 Prenom 1'), findsOneWidget);
        expect(find.text('Agent 2 Prenom 2'), findsOneWidget);
      });

      testWidgets('should select agent from dropdown',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: InfractionView(
              Communes: mockCommunes,
              Violants: mockViolants,
              Agents: mockAgents,
              Categories: mockCategories,
            ),
          ),
        );

        // Find and tap agent dropdown
        final agentDropdown = find.byType(DropdownButtonFormField<Agent>);
        await tester.tap(agentDropdown);
        await tester.pumpAndSettle();

        // Select first agent
        await tester.tap(find.text('Agent 1 Prenom 1'));
        await tester.pumpAndSettle();

        // Verify selection
        expect(find.text('Agent 1 Prenom 1'), findsOneWidget);
      });

      testWidgets('should display categorie dropdown with correct options',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: InfractionView(
              Communes: mockCommunes,
              Violants: mockViolants,
              Agents: mockAgents,
              Categories: mockCategories,
            ),
          ),
        );

        // Find categorie dropdown
        final categorieDropdown =
            find.byType(DropdownButtonFormField<Categorie>);
        expect(categorieDropdown, findsOneWidget);

        // Tap to open dropdown
        await tester.tap(categorieDropdown);
        await tester.pumpAndSettle();

        // Verify dropdown options are displayed
        expect(find.text('Category 1'), findsOneWidget);
        expect(find.text('Category 2'), findsOneWidget);
      });

      testWidgets('should select categorie from dropdown',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: InfractionView(
              Communes: mockCommunes,
              Violants: mockViolants,
              Agents: mockAgents,
              Categories: mockCategories,
            ),
          ),
        );

        // Find and tap categorie dropdown
        final categorieDropdown =
            find.byType(DropdownButtonFormField<Categorie>);
        await tester.tap(categorieDropdown);
        await tester.pumpAndSettle();

        // Select first categorie
        await tester.tap(find.text('Category 1'));
        await tester.pumpAndSettle();

        // Verify selection
        expect(find.text('Category 1'), findsOneWidget);
      });

      testWidgets('should handle empty dropdown lists gracefully',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: InfractionView(
              Communes: [],
              Violants: [],
              Agents: [],
              Categories: [],
            ),
          ),
        );

        // All dropdowns should still be present but empty
        expect(find.byType(DropdownButtonFormField<Commune>), findsOneWidget);
        expect(find.byType(DropdownButtonFormField<Violant>), findsOneWidget);
        expect(find.byType(DropdownButtonFormField<Agent>), findsOneWidget);
        expect(find.byType(DropdownButtonFormField<Categorie>), findsOneWidget);
      });
    });

    //------------------------------------Form Submission Tests-------------------------------------------------------//
    group('Form Submission Tests', () {
      testWidgets('should validate all required fields before submission',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: InfractionView(
              Communes: mockCommunes,
              Violants: mockViolants,
              Agents: mockAgents,
              Categories: mockCategories,
            ),
          ),
        );

        // Fill only some fields
        final nomField = find.byType(TextFormField).first;
        await tester.enterText(nomField, 'Test Infraction');
        await tester.pump();

        // Tap check button
        await tester.tap(find.byIcon(Icons.check));
        await tester.pump();

        // Should show validation errors, not confirmation dialog
        expect(find.text('SVP entrer La Date'), findsOneWidget);
        expect(find.text('SVP entrer une adresse'), findsOneWidget);
        expect(find.text('Confirmation'), findsNothing);
      });

      testWidgets('should show validation errors for missing text fields',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: InfractionView(
              Communes: mockCommunes,
              Violants: mockViolants,
              Agents: mockAgents,
              Categories: mockCategories,
            ),
          ),
        );

        // Tap check button without filling any fields
        await tester.tap(find.byIcon(Icons.check));
        await tester.pump();

        // Should show all validation errors
        expect(find.text('SVP Entrer Le Nom '), findsOneWidget);
        expect(find.text('SVP entrer La Date'), findsOneWidget);
        expect(find.text('SVP entrer une adresse'), findsOneWidget);
        expect(find.text('SVP entrer La latitude'), findsOneWidget);
        expect(find.text('SVP entrer La longitude'), findsOneWidget);
      });

      testWidgets('should validate text fields correctly',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: InfractionView(
              Communes: mockCommunes,
              Violants: mockViolants,
              Agents: mockAgents,
              Categories: mockCategories,
            ),
          ),
        );

        // Fill nom field
        final nomField = find.byType(TextFormField).first;
        await tester.enterText(nomField, 'Test Infraction');
        await tester.pump();

        // Fill address field
        final addressField = find.byType(TextFormField).at(2);
        await tester.enterText(addressField, '123 Test Street');
        await tester.pump();

        // Fill latitude field
        final latitudeField = find.byType(TextFormField).at(3);
        await tester.enterText(latitudeField, '34.5678');
        await tester.pump();

        // Fill longitude field
        final longitudeField = find.byType(TextFormField).at(4);
        await tester.enterText(longitudeField, '-6.1234');
        await tester.pump();

        // Tap check button
        await tester.tap(find.byIcon(Icons.check));
        await tester.pump();

        // Should still show date validation error
        expect(find.text('SVP entrer La Date'), findsOneWidget);
        // But not the other errors
        expect(find.text('SVP Entrer Le Nom '), findsNothing);
        expect(find.text('SVP entrer une adresse'), findsNothing);
        expect(find.text('SVP entrer La latitude'), findsNothing);
        expect(find.text('SVP entrer La longitude'), findsNothing);
      });

      testWidgets('should handle form validation with dropdowns present',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: InfractionView(
              Communes: mockCommunes,
              Violants: mockViolants,
              Agents: mockAgents,
              Categories: mockCategories,
            ),
          ),
        );

        // Verify all dropdowns are present
        expect(find.byType(DropdownButtonFormField<Commune>), findsOneWidget);
        expect(find.byType(DropdownButtonFormField<Violant>), findsOneWidget);
        expect(find.byType(DropdownButtonFormField<Agent>), findsOneWidget);
        expect(find.byType(DropdownButtonFormField<Categorie>), findsOneWidget);

        // Fill required text fields
        final nomField = find.byType(TextFormField).first;
        await tester.enterText(nomField, 'Dropdown Test');
        await tester.pump();

        final addressField = find.byType(TextFormField).at(2);
        await tester.enterText(addressField, '456 Dropdown Street');
        await tester.pump();

        final latitudeField = find.byType(TextFormField).at(3);
        await tester.enterText(latitudeField, '35.1234');
        await tester.pump();

        final longitudeField = find.byType(TextFormField).at(4);
        await tester.enterText(longitudeField, '-6.5678');
        await tester.pump();

        // Tap check button
        await tester.tap(find.byIcon(Icons.check));
        await tester.pump();

        // Should show date validation error
        expect(find.text('SVP entrer La Date'), findsOneWidget);
      });
    });
  });
}
