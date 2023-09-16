abstract class BaseViewModel extends BaseViewModelInputs
    implements BaseViewModelOutputs {


}


abstract class BaseViewModelInputs {
  void start(); // View model start job

  void dispose(); // ViewModel end job
}

abstract class BaseViewModelOutputs {
}