# Rename Repositories to Kebab-Case

## Instructions
For each repository, replace `$USER` with your GitHub username or organization. Replace `$BRANCH` with the branch you want to commit the rename (usually `main` or `development`).  

---

# Define your GitHub username or organization
```powershell
$USER = "panagiotisbellias"
$BRANCH = "development"  # or "main", whichever branch you want to push to
```

# Root folder containing all repos
```powershell
$ROOT_DIR='~/Projects/Personal/android-apps'
$ROOT2_DIR='~/Projects/Personal/desktop-apps'

cd $ROOT_DIR

# Assignment → assignment
# Temporary intermediate name
Rename-Item -Path "Assignment" -NewName "temp-assignment"
# Rename to final kebab-case
Rename-Item -Path "temp-assignment" -NewName "assignment"
cd assignment
git add -A
git commit -m "Rename repository folder to kebab-case: Assignment -> assignment"
git push origin $BRANCH
gh repo rename --repo $USER/Assignment assignment
cd $ROOT_DIR

# AsyncTaskActivity → async-task-activity
Rename-Item -Path "AsyncTaskActivity" -NewName "async-task-activity"
cd async-task-activity
git add -A
git commit -m "Rename repository folder to kebab-case: AsyncTaskActivity -> async-task-activity"
git push origin $BRANCH
gh repo rename --repo $USER/AsyncTaskActivity async-task-activity
cd $ROOT_DIR

# BoundService → bound-service
Rename-Item -Path "BoundService" -NewName "bound-service"
cd bound-service
git add -A
git commit -m "Rename repository folder to kebab-case: BoundService -> bound-service"
git push origin $BRANCH
gh repo rename --repo $USER/BoundService bound-service
cd $ROOT_DIR

# BRClassExample → br-class-example
Rename-Item -Path "BRClassExample" -NewName "br-class-example"
cd br-class-example
git add -A
git commit -m "Rename repository folder to kebab-case: BRClassExample -> br-class-example"
git push origin $BRANCH
gh repo rename --repo $USER/BRClassExample br-class-example
cd $ROOT_DIR

# BroadcastReceiverExample → broadcast-receiver-example
Rename-Item -Path "BroadcastReceiverExample" -NewName "broadcast-receiver-example"
cd broadcast-receiver-example
git add -A
git commit -m "Rename repository folder to kebab-case: BroadcastReceiverExample -> broadcast-receiver-example"
git push origin $BRANCH
gh repo rename --repo $USER/BroadcastReceiverExample broadcast-receiver-example
cd $ROOT_DIR

# ClassExampleApp → class-example-app
Rename-Item -Path "ClassExampleApp" -NewName "class-example-app"
cd class-example-app
git add -A
git commit -m "Rename repository folder to kebab-case: ClassExampleApp -> class-example-app"
git push origin $BRANCH
gh repo rename --repo $USER/ClassExampleApp class-example-app
cd $ROOT_DIR

# ContactsContentProvider → contacts-content-provider
Rename-Item -Path "ContactsContentProvider" -NewName "contacts-content-provider"
cd contacts-content-provider
git add -A
git commit -m "Rename repository folder to kebab-case: ContactsContentProvider -> contacts-content-provider"
git push origin $BRANCH
gh repo rename --repo $USER/ContactsContentProvider contacts-content-provider
cd $ROOT_DIR

# ContactsContentProviderClient → contacts-content-provider-client
Rename-Item -Path "ContactsContentProviderClient" -NewName "contacts-content-provider-client"
cd contacts-content-provider-client
git add -A
git commit -m "Rename repository folder to kebab-case: ContactsContentProviderClient -> contacts-content-provider-client"
git push origin $BRANCH
gh repo rename --repo $USER/ContactsContentProviderClient contacts-content-provider-client
cd $ROOT_DIR

# DBClassExample → db-class-example
Rename-Item -Path "DBClassExample" -NewName "db-class-example"
cd db-class-example
git add -A
git commit -m "Rename repository folder to kebab-case: DBClassExample -> db-class-example"
git push origin $BRANCH
gh repo rename --repo $USER/DBClassExample db-class-example
cd $ROOT_DIR

# FirstActivityIntents → first-activity-intents
Rename-Item -Path "FirstActivityIntents" -NewName "first-activity-intents"
cd first-activity-intents
git add -A
git commit -m "Rename repository folder to kebab-case: FirstActivityIntents -> first-activity-intents"
git push origin $BRANCH
gh repo rename --repo $USER/FirstActivityIntents first-activity-intents
cd $ROOT_DIR

# DBExample → db-example
Rename-Item -Path "DBExample" -NewName "db-example"
cd db-example
git add -A
git commit -m "Rename repository folder to kebab-case: DBExample -> db-example"
git push origin $BRANCH
gh repo rename --repo $USER/DBExample db-example
cd $ROOT_DIR

# FusedLocationExample → fused-location-example
Rename-Item -Path "FusedLocationExample" -NewName "fused-location-example"
cd fused-location-example
git add -A
git commit -m "Rename repository folder to kebab-case: FusedLocationExample -> fused-location-example"
git push origin $BRANCH
gh repo rename --repo $USER/FusedLocationExample fused-location-example
cd $ROOT_DIR

# GoogleMapsExampleApp → google-maps-example-app
Rename-Item -Path "GoogleMapsExampleApp" -NewName "google-maps-example-app"
cd google-maps-example-app
git add -A
git commit -m "Rename repository folder to kebab-case: GoogleMapsExampleApp -> google-maps-example-app"
git push origin $BRANCH
gh repo rename --repo $USER/GoogleMapsExampleApp google-maps-example-app
cd $ROOT_DIR

# It21871_v1 → it21871-v1
Rename-Item -Path "It21871_v1" -NewName "it21871-v1"
cd it21871-v1
git add -A
git commit -m "Rename repository folder to kebab-case: It21871_v1 -> it21871-v1"
git push origin $BRANCH
gh repo rename --repo $USER/It21871_v1 it21871-v1
cd $ROOT_DIR

# It21871_v1_1 → it21871-v1-1
Rename-Item -Path "It21871_v1_1" -NewName "it21871-v1-1"
cd it21871-v1-1
git add -A
git commit -m "Rename repository folder to kebab-case: It21871_v1_1 -> it21871-v1-1"
git push origin $BRANCH
gh repo rename --repo $USER/It21871_v1_1 it21871-v1-1
cd $ROOT_DIR

# It21871_v2 → it21871-v2
Rename-Item -Path "It21871_v2" -NewName "it21871-v2"
cd it21871-v2
git add -A
git commit -m "Rename repository folder to kebab-case: It21871_v2 -> it21871-v2"
git push origin $BRANCH
gh repo rename --repo $USER/It21871_v2 it21871-v2
cd $ROOT_DIR

# LocationExampleApp → location-example-app
Rename-Item -Path "LocationExampleApp" -NewName "location-example-app"
cd location-example-app
git add -A
git commit -m "Rename repository folder to kebab-case: LocationExampleApp -> location-example-app"
git push origin $BRANCH
gh repo rename --repo $USER/LocationExampleApp location-example-app
cd $ROOT_DIR

# MyApplication → my-application
Rename-Item -Path "MyApplication" -NewName "my-application"
cd my-application
git add -A
git commit -m "Rename repository folder to kebab-case: MyApplication -> my-application"
git push origin $BRANCH
gh repo rename --repo $USER/MyApplication my-application
cd $ROOT_DIR

# MyDemoApp → my-demo-app
Rename-Item -Path "MyDemoApp" -NewName "my-demo-app"
cd my-demo-app
git add -A
git commit -m "Rename repository folder to kebab-case: MyDemoApp -> my-demo-app"
git push origin $BRANCH
gh repo rename --repo $USER/MyDemoApp my-demo-app
cd $ROOT_DIR

# SecondActivityIntents → second-activity-intents
Rename-Item -Path "SecondActivityIntents" -NewName "second-activity-intents"
cd second-activity-intents
git add -A
git commit -m "Rename repository folder to kebab-case: SecondActivityIntents -> second-activity-intents"
git push origin $BRANCH
gh repo rename --repo $USER/SecondActivityIntents second-activity-intents
cd $ROOT_DIR

# ServiceExampleApp → service-example-app
Rename-Item -Path "ServiceExampleApp" -NewName "service-example-app"
cd service-example-app
git add -A
git commit -m "Rename repository folder to kebab-case: ServiceExampleApp -> service-example-app"
git push origin $BRANCH
gh repo rename --repo $USER/ServiceExampleApp service-example-app
cd $ROOT_DIR

# StartedService → started-service
Rename-Item -Path "StartedService" -NewName "started-service"
cd started-service
git add -A
git commit -m "Rename repository folder to kebab-case: StartedService -> started-service"
git push origin $BRANCH
gh repo rename --repo $USER/StartedService started-service
cd $ROOT_DIR

# StartingFromScratch → starting-from-scratch
Rename-Item -Path "StartingFromScratch" -NewName "starting-from-scratch"
cd starting-from-scratch
git add -A
git commit -m "Rename repository folder to kebab-case: StartingFromScratch -> starting-from-scratch"
git push origin $BRANCH
gh repo rename --repo $USER/StartingFromScratch starting-from-scratch
cd $ROOT_DIR

# SQLiteDBExample → sqlite-db-example
Rename-Item -Path "SQLiteDBExample" -NewName "sqlite-db-example"
cd sqlite-db-example
git add -A
git commit -m "Rename repository folder to kebab-case: SQLiteDBExample -> sqlite-db-example"
git push origin $BRANCH
gh repo rename --repo $USER/SQLiteDBExample sqlite-db-example
cd $ROOT2_DIR

# E-Ticket-App → e-ticket-app
# Temporary intermediate name
Rename-Item -Path "E-Ticket-App" -NewName "temp-e-ticket-app"
# Rename to final kebab-case
Rename-Item -Path "temp-e-ticket-app" -NewName "e-ticket-app"
cd e-ticket-app
git add -A
git commit -m "Rename repository folder to kebab-case: E-Ticket-App -> e-ticket-app"
git push origin $BRANCH
gh repo rename --repo $USER/E-Ticket-App e-ticket-app
cd $ROOT2_DIR

# JAVIS-Rent-A-Motor-App → javis-rent-a-motor-app
# Temporary intermediate name
Rename-Item -Path "JAVIS-Rent-A-Motor-App" -NewName "temp-javis-rent-a-motor-app"
# Rename to final kebab-case
Rename-Item -Path "temp-javis-rent-a-motor-app" -NewName "javis-rent-a-motor-app"
cd javis-rent-a-motor-app
git add -A
git commit -m "Rename repository folder to kebab-case: JAVIS-Rent-A-Motor-App -> javis-rent-a-motor-app"
git push origin $BRANCH
gh repo rename --repo $USER/JAVIS-Rent-A-Motor-App javis-rent-a-motor-app
cd $ROOT2_DIR

# Music-Collection-Management-App → music-collection-management-app
# Temporary intermediate name
Rename-Item -Path "Music-Collection-Management-App" -NewName "temp-music-collection-management-app"
# Rename to final kebab-case
Rename-Item -Path "temp-music-collection-management-app" -NewName "music-collection-management-app"
cd music-collection-management-app
git add -A
git commit -m "Rename repository folder to kebab-case: Music-Collection-Management-App -> music-collection-management-app"
git push origin $BRANCH
gh repo rename --repo $USER/Music-Collection-Management-App music-collection-management-app
cd $ROOT2_DIR

# Port-s-Packages-Management-App → port-s-packages-management-app
# Temporary intermediate name
Rename-Item -Path "Port-s-Packages-Management-App" -NewName "temp-port-s-packages-management-app"
# Rename to final kebab-case
Rename-Item -Path "temp-port-s-packages-management-app" -NewName "port-s-packages-management-app"
cd port-s-packages-management-app
git add -A
git commit -m "Rename repository folder to kebab-case: Port-s-Packages-Management-App -> port-s-packages-management-app"
git push origin $BRANCH
gh repo rename --repo $USER/Port-s-Packages-Management-App port-s-packages-management-app
cd $ROOT2_DIR

# River-s-Dirts-App → river-s-dirts-app
# Temporary intermediate name
Rename-Item -Path "River-s-Dirts-App" -NewName "temp-river-s-dirts-app"
# Rename to final kebab-case
Rename-Item -Path "temp-river-s-dirts-app" -NewName "river-s-dirts-app"
cd river-s-dirts-app
git add -A
git commit -m "Rename repository folder to kebab-case: River-s-Dirts-App -> river-s-dirts-app"
git push origin $BRANCH
gh repo rename --repo $USER/River-s-Dirts-App river-s-dirts-app
cd $ROOT2_DIR

# School-Network-App → school-network-app
# Temporary intermediate name
Rename-Item -Path "School-Network-App" -NewName "temp-school-network-app"
# Rename to final kebab-case
Rename-Item -Path "temp-school-network-app" -NewName "school-network-app"
cd school-network-app
git add -A
git commit -m "Rename repository folder to kebab-case: School-Network-App -> school-network-app"
git push origin $BRANCH
gh repo rename --repo $USER/School-Network-App school-network-app
cd $ROOT2_DIR

# School-Volley-League-App → school-volley-league-app
# Temporary intermediate name
Rename-Item -Path "School-Volley-League-App" -NewName "temp-school-volley-league-app"
# Rename to final kebab-case
Rename-Item -Path "temp-school-volley-league-app" -NewName "school-volley-league-app"
cd school-volley-league-app
git add -A
git commit -m "Rename repository folder to kebab-case: School-Volley-League-App -> school-volley-league-app"
git push origin $BRANCH
gh repo rename --repo $USER/School-Volley-League-App school-volley-league-app
cd $ROOT2_DIR

# Seminars-App → seminars-app
# Temporary intermediate name
Rename-Item -Path "Seminars-App" -NewName "temp-seminars-app"
# Rename to final kebab-case
Rename-Item -Path "temp-seminars-app" -NewName "seminars-app"
cd seminars-app
git add -A
git commit -m "Rename repository folder to kebab-case: Seminars-App -> seminars-app"
git push origin $BRANCH
gh repo rename --repo $USER/Seminars-App seminars-app
cd $ROOT2_DIR
```
